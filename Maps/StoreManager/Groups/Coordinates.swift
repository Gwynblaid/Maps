//
//  Coordinates.swift
//  Maps
//
//  Created by Sergey Harchenko on 28.11.2021.
//

import Foundation
import CoreLocation

struct Coordinates: StorageObject, Codable {
    static var entityName: String {
        "Coordinates"
    }

    let id: String
    let coordinate: CLLocationCoordinate2D
    let timestamp: TimeInterval
    
    init(
        id: String = UUID().uuidString,
        coordinate: CLLocationCoordinate2D,
        timestamp: TimeInterval = Date().timeIntervalSince1970
    ) {
        self.id = id
        self.coordinate = coordinate
        self.timestamp = timestamp
    }
}
