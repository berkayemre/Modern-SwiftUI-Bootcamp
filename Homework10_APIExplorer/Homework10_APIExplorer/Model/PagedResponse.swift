//
//  PagedResponse.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import Foundation

struct PagedResponse<Result: Codable>: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: URL?
        let prev: URL?
    }
    let info: Info
    let results: [Result]
}
