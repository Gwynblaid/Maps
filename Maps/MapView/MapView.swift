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
    @ObservedObject var viewModel: MapViewModel = MapViewModel(locationService: LocationServiceImpl())
    @ObservedObject var tableModel = SimpleTableViewModel(cellFactory: { LocationTableCellModel(isSelected: false, location: $0) })
    
    init() {
        bind()
    }

    // TODO: - Фабрика вместо метода bind и создания моделей
    func bind() {
        tableModel.bind(
            dataPublisher: viewModel.$locations.eraseToAnyPublisher(),
            selectedPublisher: viewModel.$selectedLocation.eraseToAnyPublisher()
        )
        viewModel.bind(selectedCell: tableModel.$selectedCellOutput.eraseToAnyPublisher())
    }
    
	var body: some View {
        return HStack(alignment: .center) {
            VStack {
                SimpleTableView(model: tableModel)
            }
            VStack(alignment: .center) {
                TappableMapView(
                    annotations: $viewModel.locations,
                    selectedLocation: $viewModel.selectedLocation
                ) {
                    viewModel.locations.append($0)
                }
            }
        }
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
