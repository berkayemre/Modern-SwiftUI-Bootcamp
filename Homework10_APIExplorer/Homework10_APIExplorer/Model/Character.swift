//
//  Character.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import Foundation

struct Character: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: URL
}
