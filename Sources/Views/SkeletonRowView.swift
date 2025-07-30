//
//  SkeletonRowView.swift
//  networking-boilerplate
//
//  Created by dohyeoplim on 7/30/25.
//

import SwiftUI

public struct SkeletonRowView: View {
    public var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.gray.opacity(0.3))
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 6) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.gray.opacity(0.3))
                    .frame(height: 16)
                RoundedRectangle(cornerRadius: 4)
                    .fill(.gray.opacity(0.3))
                    .frame(width: 100, height: 14)
            }
        }
        .redacted(reason: .placeholder)
        .modifier(Shimmer())
        .padding(.vertical, 4)
    }
}

public struct Shimmer: ViewModifier {
    @State var isInitialState: Bool = true
    
    public func body(content: Content) -> some View {
        content
            .mask {
                LinearGradient(
                    gradient: .init(colors: [.black.opacity(0.4), .black, .black.opacity(0.4)]),
                    startPoint: (isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1, y: 1)),
                    endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3))
                )
            }
            .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear() {
                isInitialState = false
            }
    }
}


#Preview {
    SkeletonRowView()
}
