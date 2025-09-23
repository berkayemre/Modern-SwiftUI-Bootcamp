//
//  InfoChip.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 23.09.2025.
//
import SwiftUI

struct InfoChip: View {
    
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.black)
            Text(value)
                .font(.callout)
                .bold()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(.thinMaterial, in: Capsule())
    }
}
