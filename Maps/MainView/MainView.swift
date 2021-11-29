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

struct MainView: View {
    @ObservedObject var model: MainViewModel
    
    // TODO: - Фабрика вместо метода bind и создания моделей    
	var body: some View {
        return HStack(alignment: .center) {
            SimpleTableView(model: model.tableViewModel)
            MapView(viewModel: model.mapViewModel)
        }
	}
}
