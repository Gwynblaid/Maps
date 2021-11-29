//
//  LocationObject.swift
//  Maps
//
//  Created by Sergey Harchenko on 28.11.2021.
//

import Foundation
import CoreLocation

struct LocationObject: StorageObject, Codable {
    static var entityName: String {
        "LocationObject"
    }

    let id: String
    let location: CLLocationCoordinate2D
    let timestamp: TimeInterval
    
    init(
        location: CLLocationCoordinate2D,
        timestamp: TimeInterval = Date().timeIntervalSince1970
    ) {
        self.id = "\(location.latitude):\(location.longitude)"
        self.location = location
        self.timestamp = timestamp
    }
}
