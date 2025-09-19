//
//  NoteRow.swift
//  Homework8_CRUDNotebook
//
//  Created by Berkay Emre Aslan on 19.09.2025.
//

import SwiftUI

struct NoteRow: View {
   let note: Note
   var body: some View {
       VStack(alignment: .leading, spacing: 4) {
           Text(note.title ?? "")
               .font(.headline)
               .lineLimit(1)
           if let d = note.date {
               Text(DF.note.string(from: d))
                   .font(.caption)
                   .foregroundStyle(.secondary)
           }
       }
   }
}

#Preview {
    let preview = PersistenceController.preview
       let context = preview.container.viewContext

       let n = Note(context: context)
       n.id = UUID()
       n.title = "Örnek Not"
       n.content = "Preview içeriği"
       n.date = Date()

       return NoteRow(note: n)
           .environment(\.managedObjectContext, context)
}
