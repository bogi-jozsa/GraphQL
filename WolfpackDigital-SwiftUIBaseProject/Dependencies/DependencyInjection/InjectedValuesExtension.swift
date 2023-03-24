//
//  InjectedValuesExtension.swift
//  WolfpackDigitalSwiftUIBaseProject
//
//  Created by Dan Ilies on 21.02.2023.
//

import Foundation

// MARK: - Container

extension InjectedValues {
    private var dependencyContainer: DependencyContainer {
        get {
            guard let injected = Self[DependencyContainerKey.self] else {
                if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil {
                    let mockContainer = MockDependencyContainer()
                    Self[DependencyContainerKey.self] = mockContainer
                    return mockContainer
                } else {
                    fatalError()
                }
            }
            return injected
        }
        set {
            Self[DependencyContainerKey.self] = newValue
        }
    }
}

// MARK: - Use Cases

extension InjectedValues {
    
    var getItemsUseCase: GetItemsUseCase {
        get { return dependencyContainer.getItemsUseCase }
        set { dependencyContainer.getItemsUseCase = newValue }
    }
    
}


// MARK: - Repositories

extension InjectedValues {
    
    var itemsRepository: ItemsRepository {
        get { return dependencyContainer.itemsRepository }
        set { dependencyContainer.itemsRepository = newValue }
    }
    
}


// MARK: - APIs

extension InjectedValues {
    
    var itemsApi: ItemsApi {
        get { return dependencyContainer.itemsApi }
        set { dependencyContainer.itemsApi = newValue }
    }
    
}
