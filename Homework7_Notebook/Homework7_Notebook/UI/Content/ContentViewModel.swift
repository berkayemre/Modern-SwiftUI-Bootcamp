//
//  ContentViewModel.swift
//  Homework7_Notebook
//
//  Created by Berkay Emre Aslan on 15.09.2025.
//

import Foundation

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    private let key = "savedNotes"
    
    init() {
        loadNotes()
    }
    
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
        saveNotes()
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }
    
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decoded
        }
    }
}
