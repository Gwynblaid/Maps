//
//  SimpleTableViewModelTests.swift
//  MapsTests
//
//  Created by Sergey Harchenko on 29.11.2021.
//

import XCTest
@testable import Maps

class SimpleTableViewModelTests: XCTestCase {
    private let data = (0 ..< 4).map { _ in DataMock() }
    private lazy var sut = SimpleTableViewModel { CellMock(data: $0) }
    
    func test_SetData_CreateCells() {
        sut.data = data
        
        let expectedCells = data.map { CellMock(data: $0) }
        XCTAssertEqual(expectedCells, sut.cells)
    }

    func test_SelectData_SelectedCellOutputStillNil() throws {
        sut.data = data
        sut.selectedData = data.first
        
        XCTAssertNil(sut.selectedCellOutput)
    }
    
    func test_SeletedDataIsEmpty_DontHaveEnySelectedCell() {
        sut.data = data
        
        XCTAssertEqual(
            sut.cells.map(\.isSelected),
            data.map { _ in false }
        )
    }
    
    func test_SelectData_CellAssociatedWithDataIsSelected() throws {
        sut.data = data
        sut.selectedData = data.first

        let expectedResult = [true] + (0 ..< data.count - 1).map { _ in false }
        
        XCTAssertEqual(
            sut.cells.map(\.isSelected),
            expectedResult
        )
    }
}
