//
//  TappableMapAnnotation.swift
//  Maps
//
//  Created by Sergey Harchenko on 29.11.2021.
//

import MapKit
import Foundation

class TappableMapAnnotation: NSObject, MKAnnotation {
  let coordinate: CLLocationCoordinate2D

  init(
    coordinate: CLLocationCoordinate2D
  ) {
    self.coordinate = coordinate
    super.init()
  }
    
    var subtitle: String? {
        nil
    }

    var title: String? {
        """
            (\(coordinate.latitude.roundToPlaces(places: 3)); \(coordinate.longitude.roundToPlaces(places: 3)))
        """
    }
}
