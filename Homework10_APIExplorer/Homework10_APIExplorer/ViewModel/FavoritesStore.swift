//
//  FavoritesStore.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import Foundation

@MainActor
final class FavoritesStore: ObservableObject {
    
    @Published private(set) var ids: Set<Int> = []
    private let key = "favoriteCharacterIDs"

    init() {
        if let data = UserDefaults.standard.array(forKey: key) as? [Int] {
            ids = Set(data)
        }
    }

    func toggle(id: Int) {
        if ids.contains(id) { ids.remove(id) } else { ids.insert(id) }
        UserDefaults.standard.set(Array(ids), forKey: key)
    }

    func contains(_ id: Int) -> Bool {
        ids.contains(id)
    }
}
