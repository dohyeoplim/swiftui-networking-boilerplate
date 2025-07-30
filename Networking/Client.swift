//
//  Client.swift
//  networking-boilerplate
//
//  Created by dohyeoplim on 7/30/25.
//

import Foundation

public protocol APIClient {
    func send<T: Decodable>(_ request: APIRequest) async throws -> T
}

public actor NetworkClient: APIClient {
    public static let shared = NetworkClient(
        session: URLSession(configuration: .default),
        cache: URLCache.shared
    )
    
    private let session: URLSession
    private let cache: URLCache
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
    
    init(session: URLSession, cache: URLCache) {
        self.session = session
        self.cache = cache
    }
    
    public func send<T: Decodable>(_ request: APIRequest) async throws -> T {
        var components = URLComponents(
            url: request.baseURL.appendingPathComponent(request.path),
            resolvingAgainstBaseURL: false
        )!
        components.queryItems = request.queryItems
        
        var urlReq = URLRequest(url: components.url!)
        urlReq.httpMethod = request.method.rawValue
        urlReq.httpBody = request.body
        urlReq.cachePolicy = request.cachePolicy
        urlReq.timeoutInterval = request.timeout
        request.headers.forEach { key, val in urlReq.setValue(val, forHTTPHeaderField: key) }

        if request.method == .get,
           let cached = cache.cachedResponse(for: urlReq) {
            return try decoder.decode(T.self, from: cached.data)
        }
        
        let maxRetries = 2
        for attempt in 0...maxRetries {
            do {
                let (data, response) = try await session.data(for: urlReq)
                guard let http = response as? HTTPURLResponse,
                      (200..<300).contains(http.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                if request.method == .get {
                    cache.storeCachedResponse(
                        CachedURLResponse(response: response, data: data),
                        for: urlReq
                    )
                }
                return try decoder.decode(T.self, from: data)
            } catch {
                if attempt == maxRetries { throw error }
                try? await Task.sleep(nanoseconds: UInt64(pow(2.0, Double(attempt)) * 0.5 * 1e9))
            }
        }
        throw URLError(.unknown)
    }
}
