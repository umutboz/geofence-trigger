//
//  LocationData.swift
//  GeofenceTrigger
//
//  Created by umud on 6.12.2024.
//

import Foundation
public struct LocationData{
    public init(name:String, coordinate :Coordinate) {
        self.name = name
        self.coordinate = coordinate
    }
    public var name : String
    public var coordinate : Coordinate
}
public struct Coordinate{
    public init(latitude:Double, longitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    public var latitude: Double
    public var longitude: Double
}
