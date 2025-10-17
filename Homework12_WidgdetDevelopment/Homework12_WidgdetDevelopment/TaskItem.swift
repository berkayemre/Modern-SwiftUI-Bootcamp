//
//  Item.swift
//  Homework12_WidgdetDevelopment
//
//  Created by Berkay Emre Aslan on 15.10.2025.
//

import Foundation
import SwiftData

@Model
final class TaskItem {
    @Attribute(.unique) var id: UUID
    var title: String
    var isDone: Bool
    var createdAt: Date

    init(id: UUID = .init(), title: String, isDone: Bool = false, createdAt: Date = .init()) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.createdAt = createdAt
    }
}
