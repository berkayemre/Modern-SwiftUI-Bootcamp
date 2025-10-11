//
//  FavoritesScreen.swift
//  Homework11_MapApplicationWithLocationService
//
//  Created by Berkay Emre Aslan on 10.10.2025.
//

import SwiftUI
import MapKit
import SwiftData

struct FavoritesScreen: View {
    @Environment(\.modelContext) private var context

    @Query(sort: \FavoritePlace.createdAt, order: .reverse)
    private var favorites: [FavoritePlace]

    @State private var selectedPlace: FavoritePlace?

    @State private var previewCamera: MapCameraPosition = .automatic

    var body: some View {
        NavigationStack {
            List {
                if favorites.isEmpty {
                    ContentUnavailableView(
                        "Favori yok",
                        systemImage: "star",
                        description: Text("Haritada bir noktaya dokunarak favori ekleyin.")
                    )
                } else {
                    ForEach(favorites, id: \.id) { favorite in
                        FavoriteRow(place: favorite) {
                            selectedPlace = favorite
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Favoriler")
            .toolbar { EditButton() }
            .sheet(item: $selectedPlace) { place in
                NavigationStack {
                    Map(position: $previewCamera) {
                        Annotation(place.title, coordinate: place.coordinate) {
                            Image(systemName: "mappin.and.ellipse")
                        }
                    }
                    .navigationTitle(place.title)
                    .navigationBarTitleDisplayMode(.inline)
                    .task(id: place.id) {
                        previewCamera = .region(
                            MKCoordinateRegion(
                                center: place.coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                            )
                        )
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Kapat") { selectedPlace = nil }
                        }
                    }
                }
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled(false)
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        for idx in offsets { context.delete(favorites[idx]) }
        try? context.save()
    }
}
