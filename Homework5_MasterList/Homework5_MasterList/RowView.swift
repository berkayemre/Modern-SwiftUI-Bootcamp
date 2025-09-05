//
//  RowView.swift
//  Homework5_MasterList
//
//  Created by Berkay Emre Aslan on 4.09.2025.
//

import SwiftUI

struct RowView: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.headline)
            Text(description).font(.subheadline).foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RowView(title: "asd", description: "aserw2")
}
