//
//  MapScreen.swift
//  Homework11_MapApplicationWithLocationService
//
//  Created by Berkay Emre Aslan on 10.10.2025.

import SwiftUI
import MapKit
import SwiftData
import CoreLocation

struct MapScreen: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var location: LocationService

    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784), // İstanbul
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    @State private var isFollowingUser = false

    @State private var selectedCoord: CLLocationCoordinate2D?
    @State private var newTitle: String = ""
    @State private var isAddSheetPresented = false

    @Query(sort: \FavoritePlace.createdAt, order: .reverse)
    private var favorites: [FavoritePlace]

    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: $cameraPosition) {
                    
                    UserAnnotation()

                    ForEach(favorites, id: \.id) { favorite in
                        Annotation(favorite.title, coordinate: favorite.coordinate) {
                            VStack(spacing: 4) {
                                Image(systemName: "mappin.and.ellipse")
                                Text(favorite.title)
                                    .font(.caption2)
                            }
                        }
                    }
                }
                .mapControls {
                    MapCompass()
                    MapScaleView()
                }
                .gesture(SpatialTapGesture().onEnded { value in
                    let point = value.location
                    if let coord = proxy.convert(point, from: .local) {
                        selectedCoord = coord
                        newTitle = ""
                        isAddSheetPresented = true
                    }
                })
                .task(id: location.lastLocation?.coordinate.latLonText) {
                    guard isFollowingUser, let loc = location.lastLocation else { return }
                    withAnimation {
                        cameraPosition = .region(
                            MKCoordinateRegion(
                                center: loc.coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            )
                        )
                    }
                }
            }
            .overlay(alignment: .bottom) { liveInfo }
            .navigationTitle("Harita")
            .toolbar { toolbar }
        }
        .onAppear { location.start() }
        .onDisappear { location.stop() }
        .sheet(isPresented: $isAddSheetPresented) { addSheet }
    }

    private var liveInfo: some View {
        VStack(spacing: 6) {
            if let loc = location.lastLocation {
                Text("Konum: \(loc.coordinate.latLonText)")
                if !location.lastAddress.isEmpty {
                    Text(location.lastAddress).lineLimit(2).multilineTextAlignment(.center)
                }
            } else {
                Text("Konum alınamadı. İzin verdiğinizden emin olun.")
            }
        }
        .font(.footnote)
        .padding(10)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14))
        .padding()
    }

    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                isFollowingUser.toggle()
                if isFollowingUser, let loc = location.lastLocation {
                    withAnimation {
                        cameraPosition = .region(
                            MKCoordinateRegion(
                                center: loc.coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            )
                        )
                    }
                }
            } label: {
                Image(systemName: isFollowingUser ? "location.fill" : "location")
            }
            .accessibilityLabel(isFollowingUser ? "Takip açık" : "Takip kapalı")

            Button {
                if let loc = location.lastLocation {
                    withAnimation {
                        cameraPosition = .region(
                            MKCoordinateRegion(
                                center: loc.coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            )
                        )
                    }
                }
            } label: {
                Image(systemName: "location.circle")
            }
            .accessibilityLabel("Mevcut konuma ortala")
        }
    }

    private var addSheet: some View {
        NavigationStack {
            Form {
                Section("Bilgiler") {
                    TextField("Yer adı giriniz...", text: $newTitle)
                    if let coord = selectedCoord {
                        LabeledContent("Koordinat", value: coord.latLonText)
                    }
                }
            }
            .navigationTitle("Favoriye Ekle")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Kapat") { isAddSheetPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        guard let coord = selectedCoord else { return }
                        let place = FavoritePlace(
                            title: newTitle.isEmpty ? "Favori" : newTitle,
                            latitude: coord.latitude,
                            longitude: coord.longitude,
                            address: nil
                        )
                        context.insert(place)
                        try? context.save()
                        isAddSheetPresented = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
