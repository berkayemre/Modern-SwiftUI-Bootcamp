//
//  MovieDetailView.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 22.09.2025.
//


import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var vm: MovieDetailViewModel
    
    init(movieID: Int, movie: Movie) {
        _vm = StateObject(wrappedValue: MovieDetailViewModel(movieID: movieID, movie: movie))
    }
    
    var body: some View {
        Group {
            switch vm.state {
                case .loading:
                    ScrollView {
                        header(vm.movie.posterPath, vm.movie.backdropPath, title: vm.movie.title, year: vm.movie.releaseDate, vote: vm.movie.voteAverage)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(vm.movie.title).font(.title).bold()
                            metaRow(year: vm.movie.releaseDate, vote: vm.movie.voteAverage, runtime: nil)
                            if let overview = vm.movie.overview, !overview.isEmpty {
                                Text(overview).foregroundStyle(.secondary)
                            }
                        }
                        .padding()
                    }
                    
                case .failed(let msg):
                    VStack(spacing: 12) {
                        Text(msg).foregroundStyle(.red)
                        Button("Tekrar Dene") { Task { await vm.load() } }
                            .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case .loaded(let loaded):
                    ScrollView {
                        header(loaded.posterPath, loaded.backdropPath, title: loaded.title, year: loaded.releaseDate, vote: loaded.voteAverage)
                        VStack(alignment: .leading, spacing: 12) {
                            Text(loaded.title).font(.title).bold()
                            metaRow(year: loaded.releaseDate, vote: loaded.voteAverage, runtime: loaded.runtime)
                            
                            if let genres = loaded.genres, !genres.isEmpty {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Türler")
                                        .font(.headline)
                                    WrapChips(items: genres.map(\.name))
                                }
                            }
                            
                            if let overView = loaded.overview, !overView.isEmpty {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Özet").font(.headline)
                                    Text(overView).foregroundStyle(.secondary)
                                }
                            }
                        }
                        .padding()
                    }
            }
        }
        .navigationTitle("Detay")
        .navigationBarTitleDisplayMode(.inline)
        .task { await vm.load() }
    }
}

#Preview {
    MovieDetailView(movieID: mockMovie.id, movie: mockMovie)
}
