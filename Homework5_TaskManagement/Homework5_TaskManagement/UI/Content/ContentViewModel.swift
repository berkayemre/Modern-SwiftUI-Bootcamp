//
//  ContentViewModel.swift
//  Homework5_TaskManagement
//
//  Created by Berkay Emre Aslan on 7.09.2025.
//
import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    @Published var isAlertShowing: Bool = false
    @Published var newTaskTitle: String = ""
    @Published var isCompleted: Bool = false
    
    func addItem(_ title: String) {
        guard !title.isEmpty else { return }
        let task = Task(title: title)
        tasks.append(task)
        newTaskTitle = ""
    }
    
    func deleteItem(with task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
        }
    }
    
    func markAsDone(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
        }
    }
    
    func markAsUndone(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = false
        }
    }

}
