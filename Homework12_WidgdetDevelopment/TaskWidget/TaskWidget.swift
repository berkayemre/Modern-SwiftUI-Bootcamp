//
//  TaskWidget.swift
//  TaskWidget
//
//  Created by Berkay Emre Aslan on 15.10.2025.
//
import WidgetKit
import SwiftUI
import SwiftData
import AppIntents

struct TasksEntry: TimelineEntry {
    let date: Date
    let items: [TaskItemDTO]
}

struct TaskItemDTO: Identifiable, Hashable {
    let id: UUID
    let title: String
    let isDone: Bool
}

struct Provider: TimelineProvider {
    private func sample() -> [TaskItemDTO] {
        [
            .init(id: UUID(), title: "Örnek: Sunum hazırla", isDone: false),
            .init(id: UUID(), title: "Örnek: Kod gözden geçir", isDone: true),
            .init(id: UUID(), title: "Örnek: Rapor güncelle", isDone: false),
        ]
    }

    func placeholder(in: Context) -> TasksEntry {
        .init(date: .now, items: sample())
    }
    func getSnapshot(in: Context, completion: @escaping (TasksEntry) -> Void) {
        completion(.init(date: .now, items: sample()))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<TasksEntry>) -> Void) {
        let entry = TasksEntry(date: .now, items: loadTop())
        completion(Timeline(entries: [entry], policy: .never))
    }

    }

    private func loadTop() -> [TaskItemDTO] {
        do {
            let container = try SharedModelContainer.make()
            let context = ModelContext(container)

            var desc = FetchDescriptor<TaskItem>(
                sortBy: [SortDescriptor<TaskItem>(\.createdAt, order: .reverse)]
            )
            desc.fetchLimit = 3

            let tasks: [TaskItem] = try context.fetch(desc)
            return tasks.map { task in
                TaskItemDTO(id: task.id, title: task.title, isDone: task.isDone)
            }
        } catch {
            return [
                .init(id: .init(), title: "Örnek: Sunum hazırla", isDone: false),
                .init(id: .init(), title: "Örnek: Kod gözden geçir", isDone: true),
                .init(id: .init(), title: "Örnek: Rapor güncelle", isDone: false),
            ]
        }
    }


struct TasksWidgetEntryView: View {
    var entry: TasksEntry
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Görevler").font(.headline)
            ForEach(entry.items) { item in
                HStack {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    Text(item.title).lineLimit(1).strikethrough(item.isDone)
                    Spacer()
                    Button(intent: ToggleTaskIntent(taskID: item.id)) {
                        Text(item.isDone ? "Aç" : "Tamamla")
                    }
                    .font(.caption)
                }
            }
            Spacer(minLength: 0)
        }
        .padding()
    }
}

struct TaskWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "TasksWidget", provider: Provider()) { entry in
            TasksWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Görevler")
        .description("Son görevlerinizi görün ve tek dokunuşla tamamlayın.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

