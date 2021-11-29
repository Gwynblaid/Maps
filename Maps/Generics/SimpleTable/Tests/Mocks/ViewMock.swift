//
//  EmptyView.swift
//  Maps
//
//  Created by Sergey Harchenko on 29.11.2021.
//

import SwiftUI
@testable import Maps

struct ViewMock: View {
    enum Input {
        case body
    }
    
    @PropertyWrapper private(set) var inputs: [Input] = []
    
    var body: some View {
        inputs.append(.body)
        return VStack {}
    }
}
