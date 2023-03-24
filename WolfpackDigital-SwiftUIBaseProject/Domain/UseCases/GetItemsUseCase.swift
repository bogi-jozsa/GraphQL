//
//  GetItemsUseCase.swift
//  WolfpackDigitalSwiftUIBaseProject
//
//  Created by Dan Ilies on 20.02.2023.
//

import Foundation

struct GetItemsUseCase {
    
    @Injected(\.itemsRepository) private var repository: ItemsRepository
    
    func execute() async -> Result<[DemoItem], Error> {
        do {
            let demoItems = try await repository.getDemoItems()
            return .success(demoItems)
        } catch(let error) {
            return .failure(error)
        }
    }
    
}
