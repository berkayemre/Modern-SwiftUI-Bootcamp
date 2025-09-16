//
//  Homework8_CRUDNotebookApp.swift
//  Homework8_CRUDNotebook
//
//  Created by Berkay Emre Aslan on 15.09.2025.
//

import SwiftUI

@main
struct Homework8_CRUDNotebookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
