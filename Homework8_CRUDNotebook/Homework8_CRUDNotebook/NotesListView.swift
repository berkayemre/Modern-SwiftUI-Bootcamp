//
// NotesListView.swift
//  Homework8_CRUDNotebook
//
//  Created by Berkay Emre Aslan on 19.09.2025.
//

import SwiftUI
import CoreData

struct NotesListView: View {
    
    @State private var searchText = ""
    @State private var newestFirst = true
    @State private var showAdd = false

    var body: some View {
        NavigationStack {
            NotesListInner(searchText: searchText, newestFirst: newestFirst)
                .navigationTitle("Notlar")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Picker("Sırala", selection: $newestFirst) {
                            Text("Yeni → Eski").tag(true)
                            Text("Eski → Yeni").tag(false)
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 220)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAdd = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        .accessibilityLabel("Yeni Not Ekle")
                    }
                }
                .sheet(isPresented: $showAdd) {
                    AddNoteView()
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),
                            prompt: "Başlıkta ara")
        }
    }
}

#Preview {
    NotesListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
