//
//  LocationService.swift
//  Homework11_MapApplicationWithLocationService
//
//  Created by Berkay Emre Aslan on 11.10.2025.
//


import Foundation
import CoreLocation
import Combine


final class LocationService: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    
    @Published var authorization: CLAuthorizationStatus = .notDetermined
    @Published var lastLocation: CLLocation?
    @Published var lastAddress: String = ""
    
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 5
    }
    
    
    func requestWhenInUse() { manager.requestWhenInUseAuthorization() }
    func requestAlways() { manager.requestAlwaysAuthorization() }
    
    
    func start() {
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
    }
    
    
    func stop() { manager.stopUpdatingLocation() }
    
    
    private func reverseGeocode(_ location: CLLocation) {
        geocoder.cancelGeocode()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let self else { return }
            if let placemarks = placemarks?.first {
                let parts = [placemarks.name,
                             placemarks.thoroughfare,
                             placemarks.subLocality,
                             placemarks.locality,
                             placemarks.administrativeArea,
                             placemarks.country]
                    .compactMap { $0 }
                self.lastAddress = parts.joined(separator: ", ")
            }
        }
    }
}


extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorization = manager.authorizationStatus
        if authorization == .authorizedAlways || authorization == .authorizedWhenInUse { start() }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        lastLocation = loc
        reverseGeocode(loc)
    }
}


