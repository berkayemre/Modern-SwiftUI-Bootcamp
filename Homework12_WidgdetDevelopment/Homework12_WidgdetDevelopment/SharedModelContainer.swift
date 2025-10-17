//
//  SharedModelContainer.swift
//  Homework12_WidgdetDevelopment
//
//  Created by Berkay Emre Aslan on 15.10.2025.
//


import SwiftData
import Foundation

enum SharedModelContainer {
    static let appGroupID = "group.berkayemre.task"

    static func make() throws -> ModelContainer {
        let config = ModelConfiguration(appGroupID)
        return try ModelContainer(for: TaskItem.self, configurations: config)
    }

    static func context() throws -> ModelContext {
        try ModelContext(make())
    }
}
