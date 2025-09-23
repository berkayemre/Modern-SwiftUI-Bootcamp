//
//  MovieDetailViewModel.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 23.09.2025.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {

    enum State {
        case loading
        case loaded(MovieDetail)
        case failed(String)
    }

    @Published private(set) var state: State = .loading

    let movieID: Int
    let movie: Movie

    init(movieID: Int,
         movie: Movie) {
        self.movieID = movieID
        self.movie = movie
    }

    func load() async {
        state = .loading
        do {
            let loaded = try await TMDBAPI.fetchDetail(id: movieID)
            state = .loaded(loaded)
        } catch {
            state = .failed("Bir hata oluştu")
        }
    }
}
