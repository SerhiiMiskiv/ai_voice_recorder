//
//  SignInViewModel.swift
//  ai_voice_recorder
//
//  Created by Serhii Miskiv on 28.02.2025.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var user: UserModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var authService: AuthServiceProtocol!
    
    // MARK: - Initialization
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
        loadSavedUser()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(resetViewModel),
            name: .userDidLogout,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public
    
    func signIn() {
        isLoading = true
        errorMessage = nil
        
        authService.signInWithApple { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let user):
                    self.user = user
                    UserSessionManager.shared.save(user)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func loadSavedUser() {
        guard let savedUser = UserSessionManager.shared.getLoggedUser() else { return }
        self.user = savedUser
    }
    
    @objc private func resetViewModel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.user = nil
            self.isLoading = false
            self.errorMessage = nil
        }
    }
}
