//
//  Geofence.swift
//  GeofenceTrigger
//
//  Created by umud on 6.12.2024.
//

public class Geofence {
    // single kullanim icin
    public static let shared = Geofence()
    private let geofenceManager = GeofenceManager()

    private init() {}

    public func startGeofenceMonitoring(locations: [(name: String, latitude: Double, longitude: Double)]) {
        geofenceManager.startGeofenceMonitoring(locations: locations)
    }
}
