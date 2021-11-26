//
//  LocationTableCellModel.swift
//  Maps
//
//  Created by Sergey Harchenko on 25.11.2021.
//

import CoreLocation
import SwiftUI

struct LocationTableCellModel: CellModel {
    typealias DataType = CLLocationCoordinate2D
    typealias CellView = LocationTableCell

    var isSelected: Bool
    
    var id = UUID().uuidString

    let location: CLLocationCoordinate2D

    func createCell() -> LocationTableCell {
        LocationTableCell(model: self)
    }
}
