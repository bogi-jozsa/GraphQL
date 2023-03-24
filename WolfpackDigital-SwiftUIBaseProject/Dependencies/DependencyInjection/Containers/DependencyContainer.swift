//
//  DependencyContainer.swift
//  WolfpackDigitalSwiftUIBaseProject
//
//  Created by Dan Ilies on 21.02.2023.
//

import Foundation

protocol DependencyContainer {
    // Use Cases
    var getItemsUseCase: GetItemsUseCase { get set }
    
    // Repositories
    var itemsRepository: ItemsRepository { get set }
    
    // APIs
    var itemsApi: ItemsApi { get set }
}

struct DependencyContainerKey: InjectionKey {
    static var currentValue: DependencyContainer?
}
