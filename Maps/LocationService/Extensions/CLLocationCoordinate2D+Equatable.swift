//
//  CLLocationCoordinate2D+Equals.swift
//  Maps
//
//  Created by Sergey Harchenko on 26.11.2021.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
}
