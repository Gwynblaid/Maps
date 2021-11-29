//
//  PropertyWrapper.swift
//  Maps
//
//  Created by Sergey Harchenko on 29.11.2021.
//

import Foundation

@propertyWrapper
final class PropertyWrapper<Type> {
    var wrappedValue: Type
    
    var projectedValue: PropertyWrapper { self }
    
    init(wrappedValue: Type) {
        self.wrappedValue = wrappedValue
    }
}
