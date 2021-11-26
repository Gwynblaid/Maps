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

    func bind() {
        tableModel.bind(
            dataPublisher: viewModel.$locations.eraseToAnyPublisher(),
            selectedPublisher: viewModel.$selectedLocation.eraseToAnyPublisher()
        )
    }
    
	var body: some View {
        return HStack(alignment: .center) {
            VStack {
                SimpleTableView(model: tableModel)
                Button("Add cell") {
                    viewModel.locations.append(Cities.moscow.coordinates)
                }
            }
            VStack(alignment: .center) {
                TappableMapView(annotations: $viewModel.locations) {
                    viewModel.locations.append($0)
                }
                Button("Request") { [viewModel] in
                    viewModel.isSearchingCurrentLocation.toggle()
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
