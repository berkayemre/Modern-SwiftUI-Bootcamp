//
//  AddNoteView.swift
//  Homework8_CRUDNotebook
//
//  Created by Berkay Emre Aslan on 19.09.2025.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.managedObjectContext) private var ctx
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("BAŞLIK") {
                    TextField("Örn: Alışveriş listesi", text: $title)
                        .textInputAutocapitalization(.sentences)
                }
                Section("İÇERİK") {
                    TextEditor(text: $content)
                        .frame(minHeight: 160)
                }
            }
            .navigationTitle("Yeni Not")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Kapat") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        let note = Note(context: ctx)
                        note.id = UUID()
                        note.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        note.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
                        note.date = Date()
                        ctx.saveIfNeeded()
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddNoteView()
}
