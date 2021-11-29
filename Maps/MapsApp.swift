//
//  MapsApp.swift
//  Maps
//
//  Created by Sergey Kharchenko on 24.11.2021.
//  
//

import SwiftUI

@main
struct MapsApp: App {
    let mainViewFactory: MainViewFactory = MainViewFactoryImpl()
    
    var body: some Scene {
        WindowGroup {
            mainViewFactory.createMainView()
        }
    }
}
