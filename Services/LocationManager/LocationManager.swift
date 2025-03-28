//
//  LocationManager.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 27/03/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    private var locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }


    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func requestLocation(){
        self.locationManager.requestLocation()
    }



    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("✅ Location Updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        DispatchQueue.main.async {
            self.currentLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Location update failed: \(error.localizedDescription)")
    }

    func fetchCurrentLocation() async throws -> CLLocationCoordinate2D {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                self.locationManager.requestLocation()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let location = self.currentLocation {
                    continuation.resume(returning: location.coordinate)
                } else {
                    continuation.resume(throwing: NSError(domain: "LocationError", code: -1, userInfo: nil))
                }
            }
        }
    }
}
