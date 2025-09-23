//
//  MovieView.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 22.09.2025.
//

import SwiftUI

struct MovieView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Yükleniyor...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .failed(let msg):
                    VStack(spacing: 12) {
                        Text(msg).foregroundStyle(.red)
                        Button("Tekrar Dene") {
                            Task { await viewModel.loadPopular() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                case .loaded(let items):
                    if items.isEmpty {
                        ContentUnavailableView("Sonuç yok", systemImage: "film", description: Text("Başka bir arama deneyin."))
                    } else {
                        List(items) { movie in
                            NavigationLink(value: movie) {
                                HStack(spacing: 12) {
                                    PosterView(path: movie.posterPath)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(movie.title).font(.headline)
                                        HStack(spacing: 8) {
                                            if let releaseDate = (movie.releaseDate ?? "").split(separator: "-").first {
                                                Text(String(releaseDate))
                                            }
                                            if let voteAverage = movie.voteAverage {
                                                Text("★ \(String(format: "%.1f", voteAverage))")
                                            }
                                        }
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        if let overview = movie.overview, !overview.isEmpty {
                                            Text(overview)
                                                .lineLimit(2)
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .navigationTitle("Filmler")
            .searchable(text: $viewModel.searchText, prompt: "Ara (örn: Inception)")
            .onChange(of: viewModel.searchText) { _, _ in viewModel.onSearchTextChanged() }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movieID: movie.id, movie: movie)
            }
        }
        .task {
            if case .idle = viewModel.state {
                await viewModel.loadPopular()
            }
        }
    }
}

#Preview {
    MovieView()
}
