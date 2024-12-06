//
//  GeofenceTriggerTests.swift
//  GeofenceTriggerTests
//
//  Created by umud on 6.12.2024.
//

import XCTest
@testable import GeofenceTrigger

final class GeofenceTriggerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStartGeofenceMonitoring(){
        let sdk = Geofence.shared
        sdk.startGeofenceMonitoring(locations: [
            LocationData(name: "Konum 1", coordinate: Coordinate(latitude: 37.7749, longitude: -122.4194)),
            LocationData(name: "Konum 2", coordinate: Coordinate(latitude: 37.7749, longitude: -122.4194)),
            LocationData(name: "Konum 3", coordinate: Coordinate(latitude: 37.7749, longitude: -122.4194)),
            LocationData(name: "Konum 4", coordinate: Coordinate(latitude: 37.7749, longitude: -122.4194)),
            LocationData(name: "Konum 5", coordinate: Coordinate(latitude: 37.7749, longitude: -122.4194))
        ])
        let result = sdk.workingStatus()
        assert(result)
    }
    
    func testConfigCheckFixedSize(){
        let sdk = Geofence.shared
        let config = GeofenceConfig(fixedSize: 2)
        sdk.setConfig(config: config)
        let locations = [
            LocationData(name: "Konum 1", coordinate: Coordinate(latitude: 37.7749, longitude: -122.4194)),
            LocationData(name: "Konum 2", coordinate: Coordinate(latitude: 37.7749, longitude: -122.4194))
        ]
        let result = sdk.checkSize(size: locations.count)
        assert(result, "success check size")
    }
    
    /*
    func testCurrentLocation2(){
        let timeout: TimeInterval = 20.0
        let expectation = self.expectation(description:"Listen LocationManager. 2")
        let manager = LocationManager()
        
        var statusCode = -1
    
        manager.getCurrentLocation(completion: { location in
            if let location = location {
                print("Current Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                statusCode = 1
                expectation.fulfill()
            } else {
                expectation.fulfill()
            }
        })
    
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNotNil(statusCode)

    }
    */


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
