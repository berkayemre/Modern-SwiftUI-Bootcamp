//
//  Homework11_MapApplicationWithLocationServiceApp.swift
//  Homework11_MapApplicationWithLocationService
//
//  Created by Berkay Emre Aslan on 10.10.2025.
//

import SwiftUI
import SwiftData

@main
struct Homework11_MapApplicationWithLocationServiceApp: App {
        var body: some Scene {
            WindowGroup {
                RootView()
            }
            .modelContainer(for: [FavoritePlace.self])
        }
    }
