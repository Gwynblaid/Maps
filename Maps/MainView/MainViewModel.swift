//
//  MainViewModel.swift
//  Maps
//
//  Created by Sergey Harchenko on 29.11.2021.
//

import SwiftUI
import Combine
import MapKit

final class MainViewModel: ObservableObject {
    typealias TableViewModel = SimpleTableViewModel<LocationTableCellModel, LocationObject>

    @ObservedObject var mapViewModel: MapViewModel = MapViewModel(
        locationService: LocationServiceImpl(),
        storeManager: UserDefaultsStorageManager()
    )
    @ObservedObject var tableViewModel: TableViewModel

    private var cancellables = Set<AnyCancellable>()
    
    init(
        mapViewModel: MapViewModel,
        tableViewModel: TableViewModel
    ) {
        self.mapViewModel = mapViewModel
        self.tableViewModel = tableViewModel
        
        bind()
    }
    
    func bind() {
        mapViewModel
            .$locations
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .assign(to: \.data, on: tableViewModel)
            .store(in: &cancellables)

        mapViewModel
            .$selectedLocation
            .receive(on: DispatchQueue.main)
            .assign(to: \.selectedData, on: tableViewModel)
            .store(in: &cancellables)

        tableViewModel
            .$selectedCellOutput
            .dropFirst()
            .map {
                $0?.location
            }
            .assign(to: \.selectedLocation, on: mapViewModel)
            .store(in: &cancellables)
    }
}
