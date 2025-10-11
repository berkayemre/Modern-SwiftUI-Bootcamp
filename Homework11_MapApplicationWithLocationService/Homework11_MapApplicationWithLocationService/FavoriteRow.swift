//
//  FavoriteRow.swift
//  Homework11_MapApplicationWithLocationService
//
//  Created by Berkay Emre Aslan on 10.10.2025.
//


import SwiftUI
import CoreLocation


struct FavoriteRow: View {
    let place: FavoritePlace
    var onShow: () -> Void
    
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "star.fill")
            VStack(alignment: .leading, spacing: 4) {
                Text(place.title).font(.headline)
                Text("\(place.latitude), \(place.longitude)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                if let address = place.address, !address.isEmpty {
                    Text(address)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            Spacer()
            Button(action: onShow) { Image(systemName: "map") }
        }
    }
}
