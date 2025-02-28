//
//  AppleSignInDelegate.swift
//  ai_voice_recorder
//
//  Created by Serhii Miskiv on 28.02.2025.
//

import Foundation
import AuthenticationServices

class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate {
    private let completion: (Result<UserModel, Error>) -> Void
    
    init(completion: @escaping (Result<UserModel, Error>) -> Void) {
        self.completion = completion
    }
    
    func authorizationController(controller: ASAuthorizationController, 
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredentials = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = UserModel(id: appleIdCredentials.user,
                                 name: appleIdCredentials.fullName?.givenName,
                                 email: appleIdCredentials.email)
            completion(.success(user))
        } else {
            completion(.failure(NSError(domain: "AppleSignIn",
                                        code: -1,
                                        userInfo: [
                                            NSLocalizedDescriptionKey:
                                                "Failed to get credentials via Apple Sign In"
                                        ]
                                       )
                )
            )
        }
    }

    func authorizationController(controller: ASAuthorizationController, 
                                 didCompleteWithError error: any Error) {
        completion(.failure(error))
    }
}
