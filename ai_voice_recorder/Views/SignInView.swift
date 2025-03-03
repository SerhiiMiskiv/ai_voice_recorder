//
//  SignInView.swift
//  ai_voice_recorder
//
//  Created by Serhii Miskiv on 27.02.2025.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            
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
            }
            .navigationDestination(isPresented: Binding(
                get: {
                    viewModel.user != nil
                }, set: { _ in })) {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }

        }
    }
}

#Preview {
    SignInView()
}
