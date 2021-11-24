//
//  LocationService.swift
//  Maps
//
//  Created by Sergey Kharchenko on 24.11.2021.
//  
//

import CoreLocation
import SwiftUI

protocol LocationService {
	var currentLocation: State<CLLocationCoordinate2D> { get }

	func findCurrent()
}
