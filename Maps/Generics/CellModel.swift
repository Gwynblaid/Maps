//
//  CellModel.swift
//  Maps
//
//  Created by Sergey Harchenko on 26.11.2021.
//

import SwiftUI

protocol CellModel: Identifiable, Hashable {
    associatedtype CellView: View

    var isSelected: Bool { get set }
    func createCell() -> CellView
}

