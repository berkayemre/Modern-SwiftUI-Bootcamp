//
//  ContentView.swift
//  Homework12_WidgdetDevelopment
//
//  Created by Berkay Emre Aslan on 15.10.2025.
//

import SwiftUI
import SwiftData
import WidgetKit


struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \TaskItem.createdAt, order: .reverse) private var tasks: [TaskItem]
    
    @State private var newTitle = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Yeni Görev") {
                    HStack {
                        TextField("Başlık", text: $newTitle)
                        Button("Ekle") {
                            guard !newTitle.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                            context.insert(TaskItem(title: newTitle))
                            try? context.save()
                            newTitle = ""
                            WidgetCenter.shared.reloadTimelines(ofKind: "TasksWidget")
                        }
                    }
                }
                Section("Görevler") {
                    ForEach(tasks) { task in
                        HStack {
                            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                            Text(task.title)
                                .strikethrough(task.isDone)
                            Spacer()
                            Button(task.isDone ? "İptal" : "Tamamla") {
                                task.isDone.toggle()
                                try? context.save()
                                WidgetCenter.shared.reloadTimelines(ofKind: "TasksWidget")
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .onDelete { indexSet in
                        for i in indexSet { context.delete(tasks[i]) }
                        try? context.save()
                        WidgetCenter.shared.reloadTimelines(ofKind: "TasksWidget")
                    }
                }
            }
            .navigationTitle("Görevler")
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: TaskItem.self, inMemory: true)
}
