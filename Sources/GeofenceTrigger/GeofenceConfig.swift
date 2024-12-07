//
//  GeofenceConfig.swift
//  GeofenceTrigger
//
//  Created by umud on 6.12.2024.
//

import Foundation
public struct GeofenceConfig: Sendable{
    public init(fixedSize: Int, geofenceRadius: Double) {
        self.fixedSize = fixedSize
        self.geofenceRadius = geofenceRadius
    }
    var fixedSize : Int = 5
    var geofenceRadius : Double = 100
}
