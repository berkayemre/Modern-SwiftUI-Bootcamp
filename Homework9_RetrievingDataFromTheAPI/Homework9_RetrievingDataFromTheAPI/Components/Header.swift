//
//  Header.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 23.09.2025.
//

import SwiftUI

func header(_ poster: String?, _ backdrop: String?, title: String, year: String?, vote: Double?) -> some View {
    
    let backdropURL = backdrop.flatMap { URL(string: TMDBAPI.imageBase + $0) }
    let posterURL = poster.flatMap { URL(string: TMDBAPI.imageBase + $0) }

    return ZStack(alignment: .bottomLeading) {
        AsyncImage(url: backdropURL) { phase in
            switch phase {
            case .empty: Rectangle().fill(.thinMaterial).frame(height: 200)
            case .success(let img): img.resizable().scaledToFill().frame(height: 220).clipped()
            case .failure: Rectangle().fill(.thinMaterial).frame(height: 200)
            @unknown default: Color.clear.frame(height: 200)
            }
        }
        .overlay {
            LinearGradient(gradient: Gradient(colors: [.black.opacity(0.0), .black.opacity(0.6)]),
                           startPoint: .center, endPoint: .bottom)
        }

        HStack(spacing: 12) {
            AsyncImage(url: posterURL) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 10).fill(.thinMaterial).frame(width: 110, height: 160)
                case .success(let img):
                    img.resizable().scaledToFill().frame(width: 110, height: 160).clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.thinMaterial)
                        .overlay(Image(systemName: "film").font(.largeTitle).foregroundStyle(.secondary))
                        .frame(width: 110, height: 160)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.headline).foregroundStyle(.white)
                metaRow(year: year, vote: vote, runtime: nil)
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.trailing, 12)
        }
        .padding()
    }
}

