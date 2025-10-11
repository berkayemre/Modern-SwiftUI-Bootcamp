//
//  Coordinate+Format.swift
//  Homework11_MapApplicationWithLocationService
//
//  Created by Berkay Emre Aslan on 10.10.2025.
//

import Foundation
import CoreLocation


extension CLLocationCoordinate2D {
var latLonText: String { String(format: "%.6f, %.6f", latitude, longitude) }
}
