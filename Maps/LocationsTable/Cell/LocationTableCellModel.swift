//
//  LocationTableCellModel.swift
//  Maps
//
//  Created by Sergey Harchenko on 25.11.2021.
//

import CoreLocation
import SwiftUI

struct LocationTableCellModel: CellModel {
    var isSelected: Bool

    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }

    public var hashValue: Int {
        id.hashValue
    }
    
    var id = UUID().uuidString

    let location: CLLocationCoordinate2D

    var value: CLLocationCoordinate2D {
        location
    }
    
    func createCell() -> LocationTableCell {
        LocationTableCell(model: self)
    }
}
