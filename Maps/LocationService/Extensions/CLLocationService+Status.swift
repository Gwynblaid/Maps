//
//  CLLocationService+Status.swift
//  Maps
//
//  Created by Sergey Harchenko on 24.11.2021.
//

import CoreLocation

extension CLAuthorizationStatus {
    var isAuthorized: Bool {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
}
