//
//  API.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import Foundation

enum API {
    static let base = URL(string: "https://rickandmortyapi.com/api")!

    static func characters(page: Int? = nil, name: String? = nil) -> URL {
        var components = URLComponents(url: base.appending(path: "character"), resolvingAgainstBaseURL: false)!
        var query: [URLQueryItem] = []
        if let page { query.append(URLQueryItem(name: "page", value: String(page))) }
        if let name, !name.isEmpty { query.append(URLQueryItem(name: "name", value: name)) }
        components.queryItems = query.isEmpty ? nil : query
        return components.url!
    }
}
