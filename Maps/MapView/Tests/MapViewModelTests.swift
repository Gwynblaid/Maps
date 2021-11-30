//
//  MapViewModelTests.swift
//  MapsTests
//
//  Created by Sergey Harchenko on 30.11.2021.
//

import XCTest
@testable import Maps
import Combine

final class MapViewModelTests: XCTestCase {
    let locationService = LocationServiceMock()
    let storageManager = StorageManagerMock()
    
    lazy var sut = MapViewModel(
        locationService: locationService,
        storeManager: storageManager
    )
    
    func test_IsSearchingCurrentLocation_Toggle_PermissionsInitialStatus_RequestPermissions() {
        sut.isSearchingCurrentLocation.toggle()

        XCTAssertEqual(locationService.inputs, [.requestPermissions])
    }
    
    func test_IsSearchingCurrentLocation_Toggle_PermissionsDeniedStatus_DoNothing() {
        sut.locationServiceStatus = .denied
        sut.isSearchingCurrentLocation.toggle()

        XCTAssertEqual(locationService.inputs, [])
    }
    
    func test_PermissionsAuthorizedWhenInUseStatus_SearchCurrentLocation() {
        sut.locationServiceStatus = .authorizedWhenInUse
        
        XCTAssertEqual(locationService.inputs, [.findCurrent])
    }
    
    func test_IsSearchingCurrentLocation_Toggle_PermissionsAuthorizedWhenInUseStatus_RequestPermissions() {
        sut.locationServiceStatus = .authorizedWhenInUse
        sut.isSearchingCurrentLocation.toggle()

        XCTAssertEqual(
            locationService.inputs,
            [.findCurrent, .findCurrent]
        )
    }
    
    func test_ChangeLocationPermissionsStatus_FindCurrent() {
        _ = sut
        locationService.authorizationStatusMock.send(.authorizedWhenInUse)
        let expect = XCTestExpectation()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            expect.fulfill()
        }
        wait(for: [expect], timeout: 40)
        XCTAssertEqual(self.locationService.inputs, [.findCurrent])
    }
    
    // TODO: Продолжить тесты писать
}
