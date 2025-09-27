//
//  Homework10_APIExplorerApp.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import SwiftUI

@main
struct Homework10_APIExplorerApp: App {
    
    @StateObject private var favorites = FavoritesStore()

    var body: some Scene {
           WindowGroup {
               TabView {
                   CharacterListView()
                       .tabItem { Label("Karakterler", systemImage: "list.bullet") }
                   FavoritesView()
                       .environmentObject(favorites)
                       .tabItem { Label("Favoriler", systemImage: "star.fill") }
               }
               .environmentObject(favorites)
           }
       }
   }
