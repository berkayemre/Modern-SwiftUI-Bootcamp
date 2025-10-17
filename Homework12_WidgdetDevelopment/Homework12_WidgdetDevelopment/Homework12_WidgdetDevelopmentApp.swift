//
//  Homework12_WidgdetDevelopmentApp.swift
//  Homework12_WidgdetDevelopment
//
//  Created by Berkay Emre Aslan on 15.10.2025.
//

import SwiftUI
import SwiftData

@main
struct Homework12_WidgdetDevelopmentApp: App {
    var body: some Scene {
           WindowGroup {
               ContentView()
           }
           .modelContainer(try! SharedModelContainer.make())
       }
}
