//
//  LocationTableCell.swift
//  Maps
//
//  Created by Sergey Harchenko on 25.11.2021.
//

import SwiftUI
import MapKit

struct LocationTableCell: View {
    private let model: LocationTableCellModel
    
    init(model: LocationTableCellModel) {
        self.model = model
    }
    
    var body: some View {
        let color = model.isSelected ?
        Color(.sRGB, red: 0, green: 0, blue: 1, opacity: 0.2) : .clear
        return ZStack {
            color
            HStack {
                VStack {
                    Text("Lat: \(model.location.location.latitude)")
                    Text("Long: \(model.location.location.longitude)")
                }
                Spacer(minLength: nil)
                Image(systemName: "trash").onTapGesture {
                    self.model.onDeletion(self.model.location)
                }
            }
        }
    }
}
