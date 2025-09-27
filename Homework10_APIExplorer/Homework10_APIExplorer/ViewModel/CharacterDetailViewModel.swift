//
//  CharacterDetailViewModel.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import Foundation

@MainActor
final class CharacterDetailViewModel: ObservableObject {
    
    enum State {
        case loading,
             loaded(Character),
             error(String)
    }
    @Published private(set) var state: State = .loading

    private let service: Networking
    private let id: Int

    init(id: Int, service: Networking = NetworkService()) {
        self.id = id; self.service = service
    }

    func load() async {
        do {
            let url = API.base.appending(path: "character/\(id)")
            let char: Character = try await service.get(url)
            state = .loaded(char)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
