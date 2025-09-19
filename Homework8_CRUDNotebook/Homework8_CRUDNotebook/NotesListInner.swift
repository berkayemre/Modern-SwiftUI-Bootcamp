//
//  NotesListInner.swift
//  Homework8_CRUDNotebook
//
//  Created by Berkay Emre Aslan on 19.09.2025.
//

import SwiftUI
import CoreData

struct NotesListInner: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest private var notes: FetchedResults<Note>

    init(searchText: String, newestFirst: Bool) {
        let req: NSFetchRequest<Note> = Note.fetchRequest()

        req.sortDescriptors = [NSSortDescriptor(keyPath: \Note.date, ascending: !newestFirst)]

        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            req.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
        _notes = FetchRequest(fetchRequest: req, animation: .default)
    }

    var body: some View {
        List {
            ForEach(notes) { note in
                NavigationLink {
                    NoteDetailView(note: note)
                } label: {
                    NoteRow(note: note)
                }
            }
            .onDelete(perform: delete)
        }
        .animation(.default, value: notes.count)
    }

    private func delete(at offsets: IndexSet) {
        offsets.map { notes[$0] }.forEach(context.delete)
        context.saveIfNeeded()
    }
}

#Preview {
    NotesListInner(searchText: "newestFirst", newestFirst: true)
}
