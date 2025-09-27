//
//  FavoritesView.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var favorites: FavoritesStore
    @StateObject private var viewModel = CharacterListViewModel() 

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items.filter { favorites.contains($0.id) }) { char in
                    NavigationLink(value: char.id) {
                        HStack {
                            cachedAsyncImage(char.image, size: 48)
                            Text(char.name)
                        }
                    }
                }
            }
            .navigationTitle("Favoriler")
            .task { await viewModel.refresh() }
            .navigationDestination(for: Int.self) { id in
                CharacterDetailView(id: id)
            }
        }
    }
}


#Preview {
    FavoritesView()
        .environmentObject(FavoritesStore())
}
