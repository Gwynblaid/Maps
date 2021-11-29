//
//  MapViewModel.swift
//  Maps
//
//  Created by Sergey Harchenko on 24.11.2021.
//

import Combine
import CoreLocation
import MapKit

// TODO: - Сократить класс. Разбить на работу со стором и работу с картой.
// Добавить в него работу с таблицей, чтобы MainView имел только одну модель
final class MapViewModel: ObservableObject {
    // Не используются, ранее было сделано для того чтобы начинать с текущей геопозиции
    // TODO: Использовать в инициализации карты. Добавить кнопку  центрирования
    @Published var location: MKCoordinateRegion
    @Published var locationServiceStatus: CLAuthorizationStatus = .notDetermined
    @Published var mapSelectedLocation: CLLocationCoordinate2D?
    @Published var mapLocations: [CLLocationCoordinate2D] = []
    
    @Published var isSearchingCurrentLocation: Bool = false
    @Published var locations: [LocationObject] = []
    @Published var selectedLocation: LocationObject?

    var cancellables = Set<AnyCancellable>()
    
    private let locationService: LocationService
    private let storeManager: StorageManager

    init(
        locationService: LocationService,
        storeManager: StorageManager
    ) {
        self.locationService = locationService
        self.storeManager = storeManager
        let distance: CLLocationDistance = 6000
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
        
        let savedLocations: Set<LocationObject> =  storeManager.getAll()
        locations = Array(savedLocations)
            .sorted { $0.timestamp > $1.timestamp }
        let savedSelectedLocation: Set<SelectedLocationObject> = storeManager.getAll()
        let selectedId = savedSelectedLocation.first?.id
        selectedLocation = locations.first { $0.id == selectedId }
        $locations
            .removeDuplicates()
            .sink { [weak self] locations in
                guard let self = self else { return }
                _ = self.storeManager.save(Set(locations))
                if let selectedLocation = self.selectedLocation,
                   !locations.contains(selectedLocation)
                {
                    self.selectedLocation = nil
                }
                self.mapLocations = locations.map(\.location)
            }
            .store(in: &cancellables)
        $selectedLocation
            .removeDuplicates()
            .sink {
                self.mapSelectedLocation = $0?.location
                let _: Set<SelectedLocationObject> = self.storeManager.removeAll()
                if let id = $0?.id {
                    _ = self.storeManager.save(SelectedLocationObject(id: id))
                }
            }
            .store(in: &cancellables)
        $mapSelectedLocation
            .removeDuplicates()
            .sink { location in
                self.selectedLocation = self.locations.first { $0.location == location }
            }
            .store(in: &cancellables)
        
        $locations
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] locations in
                guard let self = self else { return }
                _ = self.storeManager.save(Set(locations))
            }
            .store(in: &cancellables)
    }
}
