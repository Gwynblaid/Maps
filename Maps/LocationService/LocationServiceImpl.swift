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
import Combine

final class LocationServiceImpl: NSObject {
	private let locationManager: CLLocationManager

    let _currentLocation: PassthroughSubject<CLLocationCoordinate2D, Never>
    let _authorizationStatatus: PassthroughSubject<CLAuthorizationStatus, Never>

    override init() {
        _currentLocation = PassthroughSubject<CLLocationCoordinate2D, Never>()
        _authorizationStatatus = PassthroughSubject<CLAuthorizationStatus, Never>()
		locationManager = CLLocationManager()

        super.init()

        locationManager.delegate = self
	}
}

extension LocationServiceImpl: LocationService {
    var currentLocation: AnyPublisher<CLLocationCoordinate2D, Never>{
        _currentLocation.eraseToAnyPublisher()
    }

    var authorizationStatus: AnyPublisher<CLAuthorizationStatus, Never>{
        Just(locationManager.authorizationStatus)
            .merge(with: _authorizationStatatus)
            .eraseToAnyPublisher()
    }

    func findCurrent() {
        if locationManager.authorizationStatus.isAuthorized {
            locationManager.requestLocation()
        }
    }

    func requestPermissions() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationServiceImpl: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let lastLocation = locations.last {
            _currentLocation.send(lastLocation.coordinate)
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        _authorizationStatatus.send(status)
    }
}
