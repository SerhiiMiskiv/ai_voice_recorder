//
//  AuthService.swift
//  ai_voice_recorder
//
//  Created by Serhii Miskiv on 28.02.2025.
//

import Foundation
import AuthenticationServices

class AuthService {
    func signInWithApple(completion: @escaping (Result<UserModel, Error>) -> Void) {
//        TODO: Uncomment this once Apple Sign In is available
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//        request.requestedScopes = [.email, .fullName]
//        
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//        let delegate = AppleSignInDelegate(completion: completion)
//        controller.delegate = delegate
//        controller.performRequests()
        
        completion(
            .success(
                UserModel(
                    id: "1",
                    name: "Serj Miskiv", 
                    email: "serjjedi@gmail.com"
                )
            )
        )
    }
}
