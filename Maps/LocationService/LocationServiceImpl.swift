//
//  LocationServiceImpl.swift
//  Maps
//
//  Created by Sergey Kharchenko on 24.11.2021.
//  
//

import CoreLocation
import SwiftUI
import Foundation

final class LocationServiceImpl: NSObject {
	private let locationManager: CLLocationManager
	var currentLocation: State<CLLocationCoordinate2D>
	
	init(
		startLocation: CLLocationCoordinate2D = Cities.moscow.coordinates
	) {
		self.currentLocation = State(initialValue: startLocation)
		self.locationManager = CLLocationManager()
		self.locationManager.delegate = self
	}
}

extension LocationServiceImpl: LocationService {
	func findCurrent() {
		<#code#>
	}
}

extension LocationServiceImpl: CLLocationManagerDelegate {
	
}
