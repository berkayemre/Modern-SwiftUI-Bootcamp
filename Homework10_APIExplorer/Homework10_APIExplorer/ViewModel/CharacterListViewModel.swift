//
//  CharacterListViewModel.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import Foundation

@MainActor
final class CharacterListViewModel: ObservableObject {
    
    enum State {
        case idle,
             loading,
             loaded,
             empty,
             error(String)
    }

    @Published private(set) var items: [Character] = []
    @Published private(set) var state: State = .idle
    @Published var query: String = ""

    private let service: Networking
    private var nextPage: Int = 1
    private var hasMore = true
    private var lastSearched = ""

    init(service: Networking = NetworkService()) { self.service = service }

    func refresh() async {
        nextPage = 1; hasMore = true
        await load(reset: true, query: query)
    }

    func loadMoreIfNeeded(current item: Character?) async {
        guard let item, hasMore else { return }
        if items.last?.id == item.id {
            await load(reset: false, query: query)
        }
    }

    func search(_ text: String) async {
        guard text != lastSearched else { return }
        lastSearched = text
        query = text
        await refresh()
    }

    private func load(reset: Bool, query: String) async {
        if reset { state = .loading; items = [] }
        guard hasMore else { return }
        do {
            let url = API.characters(page: nextPage, name: query.isEmpty ? nil : query)
            let page: PagedResponse<Character> = try await service.get(url)
            if reset && page.results.isEmpty { state = .empty; return }
            items.append(contentsOf: page.results)
            state = .loaded
            hasMore = (page.info.next != nil)
            if hasMore { nextPage += 1 }
        } catch {
            state = .error((error as? NetworkError).map(String.init(describing:)) ?? error.localizedDescription)
        }
    }
}
