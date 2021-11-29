//
//  MapView.swift
//  Maps
//
//  Created by Sergey Harchenko on 29.11.2021.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel

    var body: some View {
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
