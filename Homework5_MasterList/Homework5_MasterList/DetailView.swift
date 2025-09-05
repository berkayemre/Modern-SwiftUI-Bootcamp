//
//  DetailView.swift
//  Homework5_MasterList
//
//  Created by Berkay Emre Aslan on 4.09.2025.
//

import SwiftUI

struct DetailView: View {
    let item: Item

    var body: some View {
        VStack(spacing: 12) {
            Text(item.title).font(.title2).bold()
            Text(item.description).foregroundStyle(.secondary)
            Image(systemName: ["bookmark", "bolt", "scribble", "leaf", "globe"].randomElement()!)
                .font(.system(size: 56))
                .padding(.top, 8)
            Spacer()
        }
        .padding()
        .navigationTitle("Detay")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    DetailView(item: Item(title: "sad", description: "qwsd"))
}
