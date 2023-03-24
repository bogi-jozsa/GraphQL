//
//  HomeViewModel.swift
//  WolfpackDigitalSwiftUIBaseProject
//
//  Created by Dan Ilies on 20.02.2023.
//

import Foundation

protocol HomeDelegate: AnyObject {
    func logout()
}

final class HomeViewModel: ObservableObject {
    
    // MARK: - Properties and Init
    
    @Injected(\.getItemsUseCase) private var getItemsUseCase: GetItemsUseCase
    private weak var delegate: HomeDelegate?
    
    @Published var items: [DemoItem] = []
    @Published var errorMessage: String? = nil
    
    init(delegate: HomeDelegate? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    @MainActor
    func getDemoItems() {
        errorMessage = nil
        Task {
            let result = await getItemsUseCase.execute()
            switch(result) {
            case .success(let items): self.items = items
            case .failure(let error): self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func logout() {
        self.delegate?.logout()
    }
    
}
