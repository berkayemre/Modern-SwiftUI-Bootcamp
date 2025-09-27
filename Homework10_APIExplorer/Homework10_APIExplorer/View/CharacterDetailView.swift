//
//  CharacterDetailView.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import SwiftUI

struct CharacterDetailView: View {

    @StateObject private var viewModel: CharacterDetailViewModel
    @EnvironmentObject var favorites: FavoritesStore

    init(id: Int) {
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(id: id))
    }

    var body: some View {
        Group {
            switch viewModel.state {

            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .error(let msg):
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Yüklenemedi")
                    Text(msg)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .loaded(let char):
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        cachedAsyncImage(char.image, size: 220)
                            .frame(maxWidth: .infinity)
                            .padding(.top)

                        Text(char.name)
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal)

                        InfoRow(title: "Tür",      value: char.species)
                        InfoRow(title: "Durum",    value: char.status)
                        InfoRow(title: "Cinsiyet", value: char.gender)

                        Button {
                            favorites.toggle(id: char.id)
                        } label: {
                            Label(
                                favorites.contains(char.id) ? "Favorilerden çıkar" : "Favori",
                                systemImage: favorites.contains(char.id) ? "star.fill" : "star"
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(.blue)
                        .padding(.horizontal)
                        Spacer(minLength: 24)
                    }
                }
                .navigationTitle(char.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .task { await viewModel.load() }
    }
}
#Preview {
    CharacterDetailView(id: 1)
        .environmentObject(FavoritesStore())

}
