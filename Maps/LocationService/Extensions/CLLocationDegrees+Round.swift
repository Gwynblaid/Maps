//
//  CLLocationDegrees+Round.swift
//  Maps
//
//  Created by Sergey Harchenko on 29.11.2021.
//

import CoreLocation

extension CLLocationDegrees {
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
