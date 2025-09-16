//
//  ContentView.swift
//  Homework7_Notebook
//
//  Created by Berkay Emre Aslan on 15.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NotesViewModel()
    @State private var showAddNote = false
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.notes.isEmpty {
                    ContentUnavailableView {
                        Label("No Active Notes", systemImage: "doc.text.image.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.black)
                    } description: {
                        Text("You have not active note.")
                    }
                } else {
                    ForEach(viewModel.notes) { note in
                        NavigationLink(destination: NoteDetailView(note: note)) {
                            VStack(alignment: .leading) {
                                Text(note.title)
                                    .font(.headline)
                                Text(note.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteNote)
                }
            }
            .navigationTitle("Not Defteri")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddNote = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showAddNote) {
                AddNoteView(viewModel: viewModel)
            }
        }
    }
}


#Preview {
    ContentView()
}
