//
//  CellMock.swift
//  Maps
//
//  Created by Sergey Harchenko on 29.11.2021.
//

import Foundation
@testable import Maps

struct CellMock: CellModel, Equatable {
    enum Input {
        case createCell
        case setIsSelected(Bool)
        case getIsSelected
    }
    
    private(set) var data: DataMock
    private var _isSelected: Bool = true
    @PropertyWrapper var inputs: [Input] = []
    
    var id: String {
        data.uid
    }
    
    var isSelected: Bool {
        set {
            inputs.append(.setIsSelected(newValue))
            _isSelected = newValue
        }

        get {
            inputs.append(.getIsSelected)
            return _isSelected
        }
    }
    
    init(data: DataMock) {
        self.data = data
    }
    
    func createCell() -> ViewMock {
        ViewMock()
    }

    static func == (lhs: CellMock, rhs: CellMock) -> Bool {
        lhs.data == rhs.data
    }
}
