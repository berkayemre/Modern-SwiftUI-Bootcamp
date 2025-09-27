//
//  InfoRow.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 26.09.2025.
//
import SwiftUI

struct InfoRow: View {
    
    let title: String
    let value: String
    
    var body: some View {
       
            HStack {
                Spacer()
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.subheadline)
                Spacer()
            }
            .padding(.horizontal)

    }
}
