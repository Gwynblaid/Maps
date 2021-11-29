//
//  SimpleTable.swift
//  Maps
//
//  Created by Sergey Harchenko on 26.11.2021.
//

import SwiftUI
import Combine

final class SimpleTableViewModel<CellModelType: CellModel, DataType: Equatable>: ObservableObject {
    // Input
    @Published var data: [DataType] = []
    @Published var selectedData: DataType?

    // Output
    @Published var selectedCellOutput: CellModelType?

    // View
    var cells: [CellModelType] {
        data.map {
            var result = self.cellFactory($0)
            result.isSelected = $0 == self.selectedData
            return result
        }
    }

    let cellFactory: (DataType) -> CellModelType

    init(
        cellFactory: @escaping (DataType) -> CellModelType
    ) {
        self.cellFactory = cellFactory
    }
}
