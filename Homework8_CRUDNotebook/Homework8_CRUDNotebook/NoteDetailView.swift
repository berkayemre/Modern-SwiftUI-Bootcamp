//
//  NoteDetailView.swift
//  Homework8_CRUDNotebook
//
//  Created by Berkay Emre Aslan on 19.09.2025.
//

import SwiftUI

struct NoteDetailView: View {
    
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var note: Note
    @Environment(\.dismiss) private var dismiss

    @State private var titleDraft = ""
    @State private var contentDraft = ""

    var body: some View {
        Form {
            Section("Başlık") {
                TextField("Başlık", text: $titleDraft)
            }
            Section("İçerik") {
                TextEditor(text: $contentDraft)
                    .frame(minHeight: 220)
            }
            if let d = note.date {
                Section("Oluşturulma") {
                    Text(DF.note.string(from: d))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Not")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Kaydet") {
                    note.title = titleDraft.trimmingCharacters(in: .whitespacesAndNewlines)
                    note.content = contentDraft.trimmingCharacters(in: .whitespacesAndNewlines)
                    context.saveIfNeeded()
                    dismiss()
                }
            }
        }
        .onAppear {
            titleDraft = note.title ?? ""
            contentDraft = note.content ?? ""
        }
    }
}

#Preview {
    let preview = PersistenceController.preview
       let contect = preview.container.viewContext

       let n = Note(context: contect)
       n.id = UUID()
       n.title = "Preview Notu"
       n.content = "Bu bir önizleme içeriğidir."
       n.date = Date()

       return NavigationStack {
           NoteDetailView(note: n)
               .environment(\.managedObjectContext, contect)
       }
}
