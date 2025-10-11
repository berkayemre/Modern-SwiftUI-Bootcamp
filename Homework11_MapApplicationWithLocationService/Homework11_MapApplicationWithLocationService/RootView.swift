//
//  RootView.swift
//  Homework11_MapApplicationWithLocationService
//
//  Created by Berkay Emre Aslan on 10.10.2025.
//


import SwiftUI
import MapKit


struct RootView: View {
    @StateObject private var location = LocationService()
    
    
    var body: some View {
        TabView {
            MapScreen()
                .environmentObject(location)
                .tabItem {
                    Label("Harita", systemImage: "map")
                }
            
            
            FavoritesScreen()
                .tabItem {
                    Label("Favoriler", systemImage: "star.fill")
                }
        }
        .onAppear {
            location.requestWhenInUse()
        }
    }
}
