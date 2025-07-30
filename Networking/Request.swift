//
//  Request.swift
//  networking-boilerplate
//
//  Created by dohyeoplim on 7/30/25.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}

public struct APIRequest {
    public let baseURL: URL
    public let path: String
    public let method: HTTPMethod
    public let queryItems: [URLQueryItem]
    public let headers: [String: String]
    public let body: Data?
    public let cachePolicy: URLRequest.CachePolicy
    public let timeout: TimeInterval
    
    public init(
        baseURL: URL,
        path: String = "",
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        body: Data? = nil,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        timeout: TimeInterval = 30
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
}
