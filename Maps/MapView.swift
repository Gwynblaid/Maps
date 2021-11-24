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
	@State private var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(
			latitude: 25.7617,
			longitude: 80.1918
		),
		span: MKCoordinateSpan(
			latitudeDelta: 10,
			longitudeDelta: 10
		)
	)

	var body: some View {
		Map(coordinateRegion: $region)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
