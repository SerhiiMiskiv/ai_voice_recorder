//
//  HomeViewModel.swift
//  ai_voice_recorder
//
//  Created by Serhii Miskiv on 03.03.2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var isLoading: Bool = false
    
    init() {
        loadSavedUser()
    }
    
    func logout(completion: @escaping () -> Void) {
        isLoading = true
        UserSessionManager.shared.clear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.user = nil
            self.isLoading = false
            
            NotificationCenter.default.post(
                name: .userDidLogout,
                object: nil
            )
            
            completion()
        }
    }
    
    private func loadSavedUser() {
        guard let savedUser = UserSessionManager.shared.getLoggedUser() else { return }
        self.user = savedUser
    }
}
