//
//  MapViewModel.swift
//  Maps
//
//  Created by Sergey Harchenko on 24.11.2021.
//

import Combine
import CoreLocation
import MapKit

final class MapViewModel: ObservableObject {
    // Не используются, ранее было сделано для того чтобы начинать с текущей геопозиции
    // TODO: Использовать в инициализации карты. Добавить кнопку  центрирования
    @Published var location: MKCoordinateRegion
    @Published var locationServiceStatus: CLAuthorizationStatus = .notDetermined
    
    @Published var isSearchingCurrentLocation: Bool = false
    @Published var locations: [CLLocationCoordinate2D] = []
    @Published var selectedLocation: CLLocationCoordinate2D?

    var cancellables = Set<AnyCancellable>()
    
    private let locationService: LocationService

    init(locationService: LocationService) {
        self.locationService = locationService
        let distance: CLLocationDistance = 1000
        location = MKCoordinateRegion(
            center: Cities.moscow.coordinates,
            latitudinalMeters: distance,
            longitudinalMeters: distance
        )
        self.locationService.currentLocation
            .map {
                MKCoordinateRegion(
                    center: $0,
                    latitudinalMeters: distance,
                    longitudinalMeters: distance
                )
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.location, on: self)
            .store(in: &cancellables)
        self.locationService
            .authorizationStatatus
            .receive(on: DispatchQueue.main)
            .assign(to: \.locationServiceStatus, on: self)
            .store(in: &cancellables)
        
        $locationServiceStatus
            .sink { [weak self] status in
                if status.isAuthorized {
                    self?.locationService.findCurrent()
                }
            }
            .store(in: &cancellables)
        $isSearchingCurrentLocation
            .removeDuplicates()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.locationServiceStatus.isAuthorized {
                    self.locationService.findCurrent()
                } else if case .notDetermined = self.locationServiceStatus {
                    self.locationService.requestPermissions()
                }
            }
            .store(in: &cancellables)
    }
    
    func bind(
        selectedCell: AnyPublisher<LocationTableCellModel?, Never>
    ) {
        selectedCell
            .map { $0?.location }
            .assign(to: \.selectedLocation, on: self)
            .store(in: &cancellables)
    }
}
