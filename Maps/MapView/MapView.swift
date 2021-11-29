//
//  ContentView.swift
//  Maps
//
//  Created by Sergey Kharchenko on 24.11.2021.
//  
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel = MapViewModel(
        locationService: LocationServiceImpl(),
        storeManager: UserDefaultsStorageManager()
    )
    @ObservedObject var tableModel: SimpleTableViewModel<LocationTableCellModel, LocationObject>
    
    init() {
        weak var viewModel: MapViewModel?
        tableModel = SimpleTableViewModel(
            cellFactory: {
                LocationTableCellModel(
                    isSelected: false,
                    location: $0,
                    onDeletion: { locationObject in
                        guard let viewModel = viewModel else {
                            return
                        }
                        viewModel.locations = viewModel.locations.filter { $0 != locationObject }
                    })
            })
        bind()
        viewModel = self.viewModel
    }

    // TODO: - Фабрика вместо метода bind и создания моделей
    func bind() {
        tableModel.bind(
            dataPublisher: viewModel
                .$locations
                .eraseToAnyPublisher(),
            selectedPublisher: viewModel.$selectedLocation.eraseToAnyPublisher()
        )
        viewModel.bind(selectedCell: tableModel.$selectedCellOutput.eraseToAnyPublisher())
    }
    
	var body: some View {
        return HStack(alignment: .center) {
            SimpleTableView(model: tableModel)
            TappableMapView(
                location: $viewModel.location,
                annotations: $viewModel.mapLocations,
                selectedLocation: $viewModel.mapSelectedLocation,
                onLongPress: {
                    viewModel.locations.append(LocationObject(location: $0))
                },
                onDeletedMark: { _ in
                    viewModel.locations = viewModel.locations.filter { $0 != viewModel.selectedLocation }
                }
            )
        }
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
