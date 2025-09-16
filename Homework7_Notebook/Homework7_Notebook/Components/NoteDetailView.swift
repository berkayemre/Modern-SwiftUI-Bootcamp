//
//  NoteDetailView.swift
//  Homework7_Notebook
//
//  Created by Berkay Emre Aslan on 15.09.2025.
//
import SwiftUI

struct NoteDetailView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.title)
                .font(.largeTitle)
                .bold()
            Text(note.date.formatted(date: .long, time: .shortened))
                .font(.subheadline)
                .foregroundColor(.gray)
            Divider()
            Text(note.content)
                .font(.body)
            Spacer()
        }
        .padding()
    }
}
