//
//  Geofence.swift
//  GeofenceTrigger
//
//  Created by umud on 6.12.2024.
//
import CoreLocation
public class Geofence {
    // single kullanim icin
    public static let shared: Geofence = {
        let instance = Geofence()
        return instance
    }()
    private let geofenceManager = GeofenceManager()
    private var workingState: Bool = false
    private let accessQueue = DispatchQueue(label: "com.geofence.access", attributes: .concurrent)

    private init() {}

    /* Start Geofence */
    open func startGeofenceMonitoring(locations: [LocationData]){
        if self.checkSize(size: locations.count) {
            self.geofenceManager.startGeofenceMonitoring(locations: locations)
            self.workingState = true
        }
    }
    
    /// stop monitoring
    open func stopGeofenceMonitoring(){
        geofenceManager.stopGeofenceMonitoring()
    }
    
    open func currentLocation(completion: @escaping (CLLocation?) -> Void) {
        
    }
    
    /* Config Set */
    open func setConfig(config: GeofenceConfig){
        self.geofenceManager.setConfig(config: config)
    }
    
    open func workingStatus() -> Bool{
        var status: Bool = false
        status = self.workingState
        return status
    }
    
    /* Check Size */
    open func checkSize(size : Int) -> Bool {
        var result: Bool = false
        result = self.geofenceManager.checkSize(size: size)
        return result
    }
    
}
