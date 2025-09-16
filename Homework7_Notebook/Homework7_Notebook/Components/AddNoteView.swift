//
//  AddNoteView.swift
//  Homework7_Notebook
//
//  Created by Berkay Emre Aslan on 15.09.2025.
//
import SwiftUI

struct AddNoteView: View {
    
    @ObservedObject var viewModel: NotesViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Başlık", text: $title)
                TextField("İçerik", text: $content, axis: .vertical)
                    .lineLimit(5...10)
            }
            .navigationTitle("Yeni Not")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Vazgeç") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kaydet") {
                        guard !title.isEmpty, !content.isEmpty else { return }
                        viewModel.addNote(title: title, content: content)
                        dismiss()
                    }
                }
            }
        }
    }
}
