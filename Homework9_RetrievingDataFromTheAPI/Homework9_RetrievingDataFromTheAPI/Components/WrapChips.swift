//
//  WrapChips.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 23.09.2025.
//
import SwiftUI

struct WrapChips: View {
    
    let items: [String]
    
    var body: some View {
        
           LazyVGrid(
            columns: [GridItem(.fixed(110))],
            spacing: 12)
        {
               ForEach(items, id: \.self) { s in
                   Text(s)
                       .font(.subheadline)
                       .padding(.horizontal, 12)
                       .padding(.vertical, 8)
                       .background(Color.gray.opacity(0.15), in: Capsule())
               }
           }
       }
}
