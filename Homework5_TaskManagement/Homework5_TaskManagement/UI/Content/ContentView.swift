//
//  ContentView.swift
//  Homework5_TaskManagement
//
//  Created by Berkay Emre Aslan on 7.09.2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        
        NavigationStack {
            List {
                // MARK: - ACTIVE TASKS
                Section(header: Text("ACTIVE TASKS")
                    .font(.headline)
                    .bold()
                ) {
                    if viewModel.tasks.filter({ !$0.isCompleted }).isEmpty {
                        ContentUnavailableView {
                            Label("No Active Tasks", systemImage: "checkmark.circle")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.green)
                        } description: {
                            Text("You have completed all active tasks.")
                        }
                    } else {
                        ForEach(viewModel.tasks.filter { !$0.isCompleted }) { task in
                            HStack {
                                RowView(title: task.title)
                                Spacer()
                                Button {
                                    viewModel.markAsDone(task)
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        .imageScale(.large)
                                        .foregroundStyle(.green)
                                }
                                .buttonStyle(.borderless)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deleteItem(with: task)
                                } label: {
                                    Text("Delete")
                                }
                            }
                        }
                    }
                }
                
                // MARK: - COMPLETED TASKS
                Section(header: Text("COMPLETED TASKS")
                    .font(.headline)
                    .bold()
                ) {
                    if viewModel.tasks.filter({ $0.isCompleted }).isEmpty {
                        ContentUnavailableView {
                            Label("No Completed Tasks", systemImage: "xmark.circle")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.red)
                        } description: {
                            Text("Tasks you complete will appear here.")
                        }
                    } else {
                        ForEach(viewModel.tasks.filter { $0.isCompleted }) { task in
                            HStack {
                                RowView(title: task.title)
                                Spacer()
                                Button {
                                    viewModel.markAsUndone(task)
                                } label: {
                                    Image(systemName: "xmark.circle")
                                        .imageScale(.large)
                                        .foregroundStyle(.red)
                                }
                                .buttonStyle(.borderless)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deleteItem(with: task)
                                } label: {
                                    Text("Delete")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { viewModel.isAlertShowing.toggle() } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .alert("Create a new task", isPresented: $viewModel.isAlertShowing) {
            TextField("New Task", text: $viewModel.newTaskTitle)
            Button("Add") {
                viewModel.addItem(viewModel.newTaskTitle)
            }
        }
    }
}

#Preview {
    ContentView()
}
