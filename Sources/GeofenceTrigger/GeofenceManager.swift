//
//  GeofenceManager.swift
//  GeofenceTrigger
//
//  Created by umud on 6.12.2024.
//

import CoreLocation
import UserNotifications

public class GeofenceManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var regions: [CLCircularRegion] = []
    private var config : GeofenceConfig = GeofenceConfig()

    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    public func checkSize(size: Int) -> Bool{
        if size == self.config.fixedSize{
            return true
        }
        else{
            print("Geofence locations must be define \(String(describing: self.fixedSize()))")
        }
        return self.regions.count == self.config.fixedSize
    }
    
    
    public func currentLocation(completion: @escaping (CLLocation?) -> Void) {
        locationManager.requestLocation()
        locationManager.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else {
                print("self is nil.")
                completion(nil)
                return
            }
            completion(self.locationManager.location)
        }
    }

    public func startGeofenceMonitoring(locations: [LocationData]) {
        for location in locations {
            let region = CLCircularRegion(
                center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                radius: 100,  // 100 metre yarıçap
                identifier: location.name
            )
            region.notifyOnEntry = true
            region.notifyOnExit = true
            self.regions.append(region)
            locationManager.startMonitoring(for: region)
        }
    }

    // enter Area ve notification gonderimi
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let circularRegion = region as? CLCircularRegion {
            sendNotification(title: "Enter Done", message: "\(circularRegion.identifier) You have entered the area.")
        }
    }
    
    // exit Area ve notification gonderimi
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let circularRegion = region as? CLCircularRegion {
            sendNotification(title: "Exit Done", message: "\(circularRegion.identifier) You have left the area.")
        }
    }

    // notification gonderimi
    private func sendNotification(title: String, message: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    public func setConfig(config: GeofenceConfig){
        self.config = config
    }
    
    public func fixedSize()-> Int{
        return self.config.fixedSize
    }
    
    
}
