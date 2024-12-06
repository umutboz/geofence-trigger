//
//  LocationManager.swift
//  GeofenceTrigger
//
//  Created by umud on 7.12.2024.
//

import Foundation
import CoreLocation

open class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var completion: ((CLLocation?) -> Void)?

    override public init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    public func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    open func getCurrentLocation(completion: @escaping (CLLocation?) -> Void) {
        self.completion = completion
        locationManager.requestLocation()
    }

    // CLLocationManagerDelegate Methods
    open func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            completion?(nil)
            return
        }
        completion?(location)
        self.completion = nil // Tamamlandiktan sonra closure temizle
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Not Found: \(error.localizedDescription)")
        completion?(nil)
        self.completion = nil // Hata durumunda da closure temizle
    }
}
