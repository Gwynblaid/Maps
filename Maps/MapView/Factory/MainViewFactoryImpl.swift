//
//  MainViewFactoryImpl.swift
//  Maps
//
//  Created by Sergey Harchenko on 29.11.2021.
//

final class MainViewFactoryImpl: MainViewFactory {
    func createMainView() -> MainView {
        let mapViewModel = MapViewModel(
            locationService: LocationServiceImpl(),
            storeManager: UserDefaultsStorageManager()
        )
        
        let tableViewModel = SimpleTableViewModel(
            cellFactory: {
                LocationTableCellModel(
                    isSelected: false,
                    location: $0,
                    onDeletion: { [weak mapViewModel] locationObject in
                        guard let mapViewModel = mapViewModel else { return }
                        mapViewModel.locations = mapViewModel.locations.filter { $0 != locationObject }
                    })
            }
        )
        
        let mainViewModel = MainViewModel(
            mapViewModel: mapViewModel,
            tableViewModel: tableViewModel
        )
        return MainView(model: mainViewModel)
    }
}
