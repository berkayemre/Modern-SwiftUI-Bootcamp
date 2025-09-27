//
//  ImageCache.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import UIKit
import SwiftUI

final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()

    func image(for url: URL) -> UIImage? { cache.object(forKey: url as NSURL) }

    func load(url: URL) async throws -> UIImage {
        if let img = image(for: url) { return img }
        let (data, _) = try await URLSession.shared.data(from: url)
        let img = UIImage(data: data) ?? UIImage()
        cache.setObject(img, forKey: url as NSURL)
        return img
    }
}

@MainActor
func cachedAsyncImage(_ url: URL, size: CGFloat = 64) -> some View {
    AsyncImage(url: url) { phase in
        switch phase {
        case .empty: ProgressView().frame(width: size, height: size)
        case .success(let img): img.resizable().scaledToFill().frame(width: size, height: size).clipShape(RoundedRectangle(cornerRadius: 12))
        case .failure: Image(systemName: "photo").frame(width: size, height: size)
        @unknown default: Color.gray.frame(width: size, height: size)
        }
    }
}
