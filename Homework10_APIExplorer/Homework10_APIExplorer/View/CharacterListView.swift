//
//  CharacterListView.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import SwiftUI

struct CharacterListView: View {
    
    @StateObject private var viewModel = CharacterListViewModel()
    @EnvironmentObject var favorites: FavoritesStore

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Rick & Morty")
                .searchable(text: Binding(
                    get: { viewModel.query },
                    set: { new in Task { await viewModel.search(new) } }
                ), prompt: "İsme göre ara…")
                .refreshable { await viewModel.refresh() }
                .task { if case .idle = viewModel.state { await viewModel.refresh() } }
        }
    }

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
        case .empty:
            VStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                Text("Sonuç yok")
                Text("Arama terimini değiştirin.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        case .error(let message):
            VStack(spacing: 8) {
                Image(systemName: "wifi.exclamationmark")
                Text("Something went wrong")
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                Button("Tekrar Dene") {
                    Task { await viewModel.refresh() }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
            List(viewModel.items) { char in
                NavigationLink(value: char.id) {
                    HStack(spacing: 12) {
                        cachedAsyncImage(char.image, size: 64)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(char.name)
                                .font(.headline)
                            Text("\(char.species) • \(char.status)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button {
                            favorites.toggle(id: char.id)
                        } label: {
                            Image(systemName: favorites.contains(char.id) ? "star.fill" : "star")
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .onAppear { Task { await viewModel.loadMoreIfNeeded(current: char) } }
            }
            .navigationDestination(for: Int.self) { id in
                CharacterDetailView(id: id)
            }
        }
    }
}
#Preview {
    CharacterListView()
}
