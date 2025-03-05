//
//  SignInViewModelTests.swift
//  ai_voice_recorder_Tests
//
//  Created by Serhii Miskiv on 05.03.2025.
//

import Testing
@testable import ai_voice_recorder
import Foundation

// MARK: Mocked Auth Service
class MockedAuthServiceImpl: AuthServiceProtocol {
    var mockedResult: Result<UserModel, Error>?

    func signInWithApple(completion: @escaping (Result<UserModel, any Error>) -> Void) {
        if let result = mockedResult {
            completion(result)
        }
    }
}

struct SignInViewModelTests {

    @Test func testSignInSuccess() {
        // Given
        UserSessionManager.shared.clear()
        let testUser = UserModel(
            id: "1",
            name: "Test Name",
            email: "test@email.com"
        )
        let mockedAuthService = MockedAuthServiceImpl()
        mockedAuthService.mockedResult = .success(testUser)
        let viewModel = SignInViewModel(authService: mockedAuthService)

        // Then
        viewModel.signIn()

        // Then
        #expect(viewModel.user != nil, "ViewModsel's user shouln't be nil after successful login")
        #expect(viewModel.user?.id == testUser.id, "ViewModel's user id should match test user id ")
        #expect(viewModel.user?.name == testUser.name, "ViewModel's user name should match test user name")
        #expect(viewModel.user?.email == testUser.email, "ViewModel's user email should match test user email")
    }
    
    @Test func testSignInFailure() {
        // Giben
//        viewModel.user = nil
//        mockedAuthService.mockedResult = .failure(
//            NSError(
//                domain: "SignIn",
//                code: -1,
//                userInfo: [
//                    NSLocalizedDescriptionKey: "Failed to get credentials via Apple Sign In"
//                ]
//            )
//        )
//        
//        // Then
//        viewModel.signIn()
//        
//        // Then
//        #expect(viewModel.user == nil, "ViewModel's user should be nil after failed login")
//        #expect(viewModel.errorMessage == "Failed to get credentials via Apple Sign In", "ViewModel's error message should match test error message")
    }
    
    @Test func testSignInLoading() {
        // Given
//        viewModel.user = nil
//        mockedAuthService.mockedResult = .success(testUser)
//        
//        // When
//        viewModel.signIn()
//        
//        // Then
//        #expect(viewModel.isLoading, "ViewModel should be in loading state after signIn call")
    }

}
