//
//  SignInViewModel.swift
//  ai_voice_recorder
//
//  Created by Serhii Miskiv on 28.02.2025.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let authService = AuthService()
    
    func signIn() {
        isLoading = true
        errorMessage = nil
        
        authService.signInWithApple { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
