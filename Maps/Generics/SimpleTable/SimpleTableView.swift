//
//  SimpleTableView.swift
//  Maps
//
//  Created by Sergey Harchenko on 26.11.2021.
//

import SwiftUI
import Combine

struct SimpleTableView<CellModelType: CellModel, DataType: Equatable>: View {
    @ObservedObject var model: SimpleTableViewModel<CellModelType, DataType>

    init(model: SimpleTableViewModel<CellModelType, DataType>) {
        self.model = model
    }

    var body: some View {
        List(model.cells) { cell in
            cell.createCell().onTapGesture { [model] in
                model.selectedCellOutput = cell
            }
        }
    }
}
