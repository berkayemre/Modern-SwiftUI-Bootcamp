//
//  FavoritePlace.swift
//  Homework11_MapApplicationWithLocationService
//
//  Created by Berkay Emre Aslan on 10.10.2025.
//


import Foundation
import SwiftData
import CoreLocation


@Model
final class FavoritePlace {
    @Attribute(.unique) var id: UUID
    var title: String
    var latitude: Double
    var longitude: Double
    var address: String?
    var createdAt: Date
    
    
    init(id: UUID = UUID(), title: String, latitude: Double, longitude: Double, address: String? = nil, createdAt: Date = .now) {
        self.id = id
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.createdAt = createdAt
    }
}


extension FavoritePlace {
    var coordinate: CLLocationCoordinate2D { .init(latitude: latitude, longitude: longitude) }
}
