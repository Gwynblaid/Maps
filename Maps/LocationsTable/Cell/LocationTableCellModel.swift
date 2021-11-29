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
    
    var id = UUID().uuidString

    let location: LocationObject
    
    let onDeletion: (_ location: LocationObject) -> Void

    func createCell() -> LocationTableCell {
        LocationTableCell(model: self)
    }
}
