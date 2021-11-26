//
//  LocationTableCell.swift
//  Maps
//
//  Created by Sergey Harchenko on 25.11.2021.
//

import SwiftUI

struct LocationTableCell: View {
    private let model: LocationTableCellModel
    
    init(model: LocationTableCellModel) {
        self.model = model
    }
    
    var body: some View {
        let color = model.isSelected ? Color(.sRGB, red: 0, green: 0, blue: 1, opacity: 0.2) : .clear
        return ZStack {
            color
            VStack {
                Text("Lat: \(model.location.latitude)")
                Text("Long: \(model.location.longitude)")
            }
        }
    }
}
