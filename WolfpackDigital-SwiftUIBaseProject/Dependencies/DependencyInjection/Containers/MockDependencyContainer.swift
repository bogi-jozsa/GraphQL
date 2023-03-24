//
//  MockDependencyContainer.swift
//  WolfpackDigitalSwiftUIBaseProject
//
//  Created by Dan Ilies on 21.02.2023.
//

import Foundation

class MockDependencyContainer: DependencyContainer {
    lazy var getItemsUseCase: GetItemsUseCase = GetItemsUseCase()
    lazy var itemsRepository: ItemsRepository = MockItemsRepositoryImpl()
    lazy var itemsApi: ItemsApi = MockItemsApiImpl()
    
    init() {
        DependencyContainerKey.currentValue = self
    }
    
}
