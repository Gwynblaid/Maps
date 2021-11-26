//
//  SimpleTable.swift
//  Maps
//
//  Created by Sergey Harchenko on 26.11.2021.
//

import SwiftUI
import Combine

final class SimpleTableViewModel<CellModelType: CellModel, DataType>: ObservableObject {
    @Published var cells: [CellModelType] = []
    @Published var selectedCell: CellModelType?

    let cellFactory: (DataType) -> CellModelType

    var cancellables = Set<AnyCancellable>()

    init(
        cellFactory: @escaping (DataType) -> CellModelType
    ) {
        self.cellFactory = cellFactory
        $selectedCell.receive(on: DispatchQueue.main)
            .sink { [weak self] selection in
                guard let self = self else { return }
                self.cells = self.cells.map {
                    var model = $0
                    model.isSelected = $0 == selection
                    return model
                }
            }
            .store(in: &cancellables)
    }
    
    func bind(
        dataPublisher: AnyPublisher<[DataType], Never>,
        selectedPublisher: AnyPublisher<DataType?, Never>
    ) {
        dataPublisher.map { data in
            data.map(self.cellFactory)
        }
        .receive(on: DispatchQueue.main)
        .assign(to: \.cells, on: self)
        .store(in: &cancellables)

        selectedPublisher.map { value in
            guard let value = value else { return nil }
            return self.cellFactory(value)
        }
        .receive(on: DispatchQueue.main)
        .assign(to: \.selectedCell, on: self)
        .store(in: &cancellables)
    }
}
