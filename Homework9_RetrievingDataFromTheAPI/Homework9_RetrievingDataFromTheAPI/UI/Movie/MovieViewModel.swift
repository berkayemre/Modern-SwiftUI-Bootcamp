//
//  MovieViewModel.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 22.09.2025.
//

import Foundation

@MainActor
final class MovieViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded([Movie])
        case failed(String)
    }

    @Published var state: State = .idle
    @Published var searchText: String = ""

    private var searchTask: Task<Void, Never>?

    func loadPopular() async {
        state = .loading
        do {
            let items = try await TMDBAPI.fetchPopular(page: 1)
            state = .loaded(items)
        } catch APIError.missingAPIKey {
            state = .failed("API anahtarı eksik. Info.plist’e TMDB_API_KEY ekleyin.")
        } catch {
            state = .failed("Bir hata oluştu")
        }
    }

    func onSearchTextChanged() {
        searchTask?.cancel()
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 400_000_000)
            guard !Task.isCancelled else { return }
            await self?.runSearch(text)
        }
    }

    private func runSearch(_ text: String) async {
        if text.count < 2 {
           
            await loadPopular()
            return
        }
        state = .loading
        do {
            let items = try await TMDBAPI.searchMovies(text, page: 1)
            state = .loaded(items)
        } catch {
            state = .failed("Bir hata oluştu")
        }
    }
}
