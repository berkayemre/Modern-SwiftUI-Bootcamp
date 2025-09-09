//
//  RowView.swift
//  Homework5_TaskManagement
//
//  Created by Berkay Emre Aslan on 8.09.2025.
//

import SwiftUI

struct RowView: View {
    var title: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.headline)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RowView(title: "asd")
}
