//
//  UserSessionManager.swift
//  ai_voice_recorder
//
//  Created by Serhii Miskiv on 03.03.2025.
//

import Foundation

class UserSessionManager {
    private let userDefaults = UserDefaults.standard
    private let userSessionKey = "kUserSession"
    
    static let shared = UserSessionManager()
    private init() {}
    
    func save(_ user: UserModel) {
        if let encoded = try? JSONEncoder().encode(user) {
            userDefaults.set(encoded, forKey: userSessionKey)
        }
    }
    
    func getLoggedUser() -> UserModel? {
        guard let storedUserData = userDefaults.data(forKey: userSessionKey),
              let user = try? JSONDecoder().decode(
                UserModel.self,
                from: storedUserData
              )
        else {
            return nil
        }
        return user
    }
    
    func clear() {
        userDefaults.removeObject(forKey: userSessionKey)
    }
}
