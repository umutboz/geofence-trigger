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
        //arka plan calismas icin aktif edildi
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    /// Geofence size kontrol eder.
    public func checkSize(size: Int) -> Bool{
        if size == self.config.fixedSize{
            return true
        }
        else{
            print("Geofence locations must be define \(String(describing: self.fixedSize()))")
        }
        return self.regions.count == self.config.fixedSize
    }
    
    /// Mevcut konumu doner.
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
    /// Belirtilen konumlar icin Geofence izlemeyi baslatir.
    public func startGeofenceMonitoring(locations: [LocationData]) {
        guard checkSize(size: locations.count) else { return }
        for location in locations {
            let region = CLCircularRegion(
                center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                radius: self.config.geofenceRadius,  // default radius 100 metre yaricap
                identifier: location.name
            )
            region.notifyOnEntry = true
            region.notifyOnExit = true
            self.regions.append(region)
            locationManager.startMonitoring(for: region)
        }
    }
    
    /// Geofence bolgesi giris/cikis olaylarını işler.
    public func handleRegionEvent(region: CLRegion, didEnter: Bool) {
        // Region identifier'i al
        let locationName = region.identifier
        // Durumu belirle
        let status = didEnter ? "Enter" : "Exit"
        // Bildirim gonder
        NotificationManager.shared.sendNotification(locationName: locationName, status: status)
    }
    
    /// cikis area
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did exit Region: \(region.identifier)")
        guard region is CLCircularRegion else { return }
        handleRegionEvent(region: region, didEnter: true)
    }
    /// cikis area
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Did Enter Region: \(region.identifier)")
        guard region is CLCircularRegion else { return }
        handleRegionEvent(region: region, didEnter: false)
    }
    
    public func setConfig(config: GeofenceConfig){
        self.config = config
    }
    
    public func fixedSize()-> Int{
        return self.config.fixedSize
    }
    
    /// Konum izin durumunu kontrol eder.
      public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
          switch manager.authorizationStatus {
          case .authorizedAlways:
              print("Authorized for always-on location updates.")
          case .denied, .restricted:
              print("Location access denied or restricted.")
          case .authorizedWhenInUse, .notDetermined:
              print("Insufficient location access permissions.")
          default:
              break
          }
      }

      /// Konum isteği hatalarını ele alır.
      public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
          print("Location Manager Error: \(error.localizedDescription)")
      }
    
    
}
