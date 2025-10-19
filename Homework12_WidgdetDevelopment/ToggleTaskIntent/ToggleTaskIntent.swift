//
//  ToggleTaskIntent.swift
//  ToggleTaskIntent
//
//  Created by Berkay Emre Aslan on 15.10.2025.
//

import AppIntents
import SwiftData
import WidgetKit

struct ToggleTaskIntent: AppIntent {
    static var title: LocalizedStringResource = "Görevi Tamamla/Aç"

    @Parameter(title: "Görev ID")
    var taskID: String

    init() {}
    init(taskID: UUID) { self.taskID = taskID.uuidString }

    func perform() async throws -> some IntentResult {
        guard let id = UUID(uuidString: taskID) else { return .result() }
        let context = try SharedModelContainer.context()
        let desc = FetchDescriptor<TaskItem>(predicate: #Predicate { $0.id == id })
        if let task = try context.fetch(desc).first {
            task.isDone.toggle()
            try context.save()
            WidgetCenter.shared.reloadTimelines(ofKind: "TaskWidget")
        }
        return .result()
    }
}
