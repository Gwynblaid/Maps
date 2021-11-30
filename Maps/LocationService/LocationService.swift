//
//  LocationService.swift
//  Maps
//
//  Created by Sergey Kharchenko on 24.11.2021.
//  
//

import CoreLocation
import Combine

protocol LocationService {
    var currentLocation: AnyPublisher<CLLocationCoordinate2D, Never> { get }
    var authorizationStatus: AnyPublisher<CLAuthorizationStatus, Never> { get }

	func findCurrent()
    func requestPermissions()
}
