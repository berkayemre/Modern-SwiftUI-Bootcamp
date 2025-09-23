//
//  PosterView.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 23.09.2025.
//

import SwiftUI

struct PosterView: View {
    let path: String?

    var body: some View {
        let url = path.flatMap { URL(string: TMDBAPI.imageBase + $0) }
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Rectangle().fill(.thinMaterial)
                    ProgressView()
                }
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                ZStack {
                    Rectangle().fill(.thinMaterial)
                    Image(systemName: "film")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
            @unknown default:
                Color.clear
            }
        }
        .frame(width: 60, height: 90)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 1)
    }
}
