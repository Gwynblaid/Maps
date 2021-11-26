//
//  SimpleTable.swift
//  Maps
//
//  Created by Sergey Harchenko on 26.11.2021.
//

import SwiftUI
import Combine

final class SimpleTableViewModel<CellModelType: CellModel, DataType: Equatable>: ObservableObject {
    @Published var data: [DataType] = []
    var selectedCell: CellModelType? {
        guard let data = selectedData else { return nil }
        return cellFactory(data)
    }
    var cells: [CellModelType] {
        data.map {
            var result = self.cellFactory($0)
            result.isSelected = $0 == self.selectedData
            return result
        }
    }
    @Published var selectedCellOutput: CellModelType?
    
    @Published var selectedData: DataType?

    let cellFactory: (DataType) -> CellModelType

    var cancellables = Set<AnyCancellable>()

    init(
        cellFactory: @escaping (DataType) -> CellModelType
    ) {
        self.cellFactory = cellFactory
    }
    
    func bind(
        dataPublisher: AnyPublisher<[DataType], Never>,
        selectedPublisher: AnyPublisher<DataType?, Never>
    ) {
        dataPublisher
        .receive(on: DispatchQueue.main)
        .removeDuplicates()
        .assign(to: \.data, on: self)
        .store(in: &cancellables)

        selectedPublisher
        .receive(on: DispatchQueue.main)
        .assign(to: \.selectedData, on: self)
        .store(in: &cancellables)
    }
}
