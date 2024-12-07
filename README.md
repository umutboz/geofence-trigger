## Geofence SDK

Geofence SDK supports a Geofence component that works with a variety of Geofence geolocation providers. This article shows how to use  Geofence component in your code.

## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### SPM PACKAGE MANAGER
This is an example of how to list things you need to use the software and how to install them with Swif Package Manager.

GeofenceSDK 1.0.0 -> https://github.com/umutboz/geofence-sdk.git
_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Get a SPM Dependency [Geofence-sdk](https://github.com/umutboz/geofence-sdk.git)
 ## Requirement
* iOS 15
* Xcode 11.0+
* Swift 5 +
2. Clone the repo
   ```sh
   https://github.com/umutboz/geofence-sdk.git
   ```
3. Install SPM packages
   ```sh
   geofence-sdk
   ```
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

## startGeofenceMonitoring
   ```swift
   import GeofenceTrigger
   
       let predefinedLocations = [
        LocationData(name: "Konum 1", coordinate: Coordinate(latitude: 37.331, longitude: -122.0307)),
        LocationData(name: "Konum 2", coordinate: Coordinate(latitude: 37.33005, longitude: -122.028600))]
    GeofenceSDK.shared.startGeofenceMonitoring(locations:predefinedLocations)
   ```
   
   ## startGeofenceMonitoring with Config, use radius, and location size
   ```swift
   import GeofenceTrigger

       let predefinedLocations = [
        LocationData(name: "Konum 1", coordinate: Coordinate(latitude: 37.331, longitude: -122.0307)),
        LocationData(name: "Konum 2", coordinate: Coordinate(latitude: 37.33005, longitude: -122.028600)),
        LocationData(name: "Konum 3", coordinate: Coordinate(latitude: 37.33003, longitude: -122.02975)),
        LocationData(name: "Konum 4", coordinate: Coordinate(latitude: 37.331049, longitude: -122.029149)),
        LocationData(name: "Konum 5", coordinate: Coordinate(latitude: 51.509980, longitude: -0.133700))
        
     let geofence = Geofence.shared
                //change raidus and location size
                let config = GeofenceConfig(fixedSize: 5, geofenceRadius: 50)
                geofence.setConfig(config: config)
                geofence.startGeofenceMonitoring(locations: predefinedLocations)
                
   ```
   
## Recieve Notification
Use "onRecieve" for SwiftUI 
must be use "GeofenceNotification" key
 ```swift
 .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GeofenceNotification"))) { notification in
            if let userInfo = notification.userInfo,
               let locationName = userInfo["locationName"] as? String,
               let status = userInfo["status"] as? String {
                notificationInfo += "\n Location: \(locationName), Status: \(status)"
            }
        }
 ```  
## Use Location Manager

  ```swift
  import GeofenceTrigger
  
     var locationManager = LocationManager()
   
   //swiftui view start location data start listen .onappear
   .onAppear{
            locationManager.checkLocationAuthorization()
        }
  ```
```swift
 VStack{
                if let coordinate = locationManager.lastKnownLocation {
                    Text("Latitude: \(coordinate.latitude)")
                    Text("Longitude: \(coordinate.longitude)")
                } else {
                    Text("Unknown Location")
                }
    }
 ```

## Notification Management
When the app is in the background or kill status, geofencing monitoring should continue and
should be able to show notifications in case of enter or exit for specified locations.
● When you click this notification (any geofence notification) that comes with the Gofencing
process, the geofencing tracking feature will be disabled and all active geofence notifications
should be cleared from the Notification Center .

AppDelegate codes use

```swift
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        // Bildirim izinlerini istemek
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        return true
    }
    
    // Bildirim tıklandığında aksiyon
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Geofencing izlemeyi durdur
        GeofenceTrigger.Geofence.shared.stopGeofenceMonitoring()
        
        // Aktif bildirimleri temizle
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        completionHandler()
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Uygulama on planda tum bildirimleri temizle
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Uygulama on planda tum bildirimleri temizle
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

 ```
## License
Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Acknowledgments
Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

* [Choose an Open Source License](https://choosealicense.com)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
