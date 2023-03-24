//
//  AppDependencyContainer.swift
//  WolfpackDigitalSwiftUIBaseProject
//
//  Created by Dan Ilies on 21.02.2023.
//

import Foundation

class AppDependencyContainer: DependencyContainer {
    lazy var getItemsUseCase: GetItemsUseCase = GetItemsUseCase()
    lazy var itemsRepository: ItemsRepository = ItemsRepositoryImpl()
    lazy var itemsApi: ItemsApi = ItemsApiImpl()
    
    init() {
        DependencyContainerKey.currentValue = self
    }
    
}
