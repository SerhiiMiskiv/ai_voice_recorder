//
//  SignInView.swift
//  ai_voice_recorder
//
//  Created by Serhii Miskiv on 27.02.2025.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                Text("Welcome \(user.name ?? "User")!")
                    .font(.title)
                    .padding()
            } else {
//                TODO: Uncomment once i have a paid Apple Developer subscription
//
//                SignInWithAppleButton(
//                    onRequest: { request in
//                        request.requestedScopes = [.email, .fullName]
//                    },
//                    onCompletion: { result in
//                        switch result {
//                        case .success(let authResult):
//                            print("Authorization successfull with creds: \(authResult.credential)")
//                        case .failure(let error):
//                            print("Authorization failure: \(error.localizedDescription)")
//                        }
//                    }
//                )
//                .frame(width: 250, height: 50)
//                .cornerRadius(10)
//                .padding()
                
                // TODO: Remove this once Apple Sign In available
                Button(
                    action: {
                        viewModel.signIn()
                    },
                    label: {
                         HStack {
                             Image(systemName: "applelogo")
                                 .foregroundColor(.white)
                             
                             Text("Sign in with Apple")
                                 .foregroundColor(.white)
                                 .bold()
                         }
                         .frame(width: 250, height: 50)
                         .background(Color.black)
                         .cornerRadius(10)
                        }
                )
                .padding()
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    SignInView()
}
