//
//  ContentView.swift
//  Maps
//
//  Created by Sergey Kharchenko on 24.11.2021.
//  
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel = MapViewModel(locationService: LocationServiceImpl())

	var body: some View {
        VStack(alignment: .center) {
            Map(coordinateRegion: $viewModel.location)
            Button("Request") { [viewModel] in
                viewModel.isSearchingCurrentLocation.toggle()
            }
        }
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
