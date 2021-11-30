//
//  LocationServiceMock.swift
//  MapsTests
//
//  Created by Sergey Harchenko on 30.11.2021.
//

@testable import Maps
import Combine
import CoreLocation

final class LocationServiceMock: LocationService {
    enum Input {
        case findCurrent
        case requestPermissions
    }
    
    let currentLocationMock = PassthroughSubject<CLLocationCoordinate2D, Never>()
    let authorizationStatusMock = PassthroughSubject<CLAuthorizationStatus, Never>()
    
    var currentLocation: AnyPublisher<CLLocationCoordinate2D, Never> {
        currentLocationMock.eraseToAnyPublisher()
    }
    var authorizationStatus: AnyPublisher<CLAuthorizationStatus, Never> {
        authorizationStatusMock.eraseToAnyPublisher()
    }
    
    private(set) var inputs: [Input] = []
    
    func findCurrent() {
        inputs.append(.findCurrent)
    }
    
    func requestPermissions() {
        inputs.append(.requestPermissions)
    }
}
