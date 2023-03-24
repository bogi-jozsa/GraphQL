//
//  LoginViewModel.swift
//  WolfpackDigitalSwiftUIBaseProject
//
//  Created by Dan Ilies on 20.02.2023.
//

import Foundation

protocol LoginDelegate: AnyObject {
    func loginCompleted()
}

final class LoginViewModel: ObservableObject {
    
    // MARK: - Properties and Init
    
    private weak var delegate: LoginDelegate?
    
    @Published var isLoading: Bool = false
    
    init(delegate: LoginDelegate? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    
    func performLogin() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.delegate?.loginCompleted()
        }
    }
}
