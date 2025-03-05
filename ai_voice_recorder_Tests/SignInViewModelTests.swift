import Testing
import Foundation
@testable import ai_voice_recorder

// MARK: - MockAuthService
class MockAuthService: AuthServiceProtocol {
    var result: Result<UserModel, Error>?

    func signInWithApple(completion: @escaping (Result<UserModel, Error>) -> Void) {
        if let result = self.result {
            completion(result)
        }
    }
}

@Suite struct SignInViewModelTests {
    var viewModel: SignInViewModel!
    var mockAuthService: MockAuthService!

    init() {
        mockAuthService = MockAuthService()
        viewModel = SignInViewModel(authService: mockAuthService)
    }

    @Test func testSignInSuccess() async {
        // Given
        let testUser = UserModel(
            id: "12345",
            name: "Test User",
            email: "test@example.com"
        )
        mockAuthService.result = .success(testUser)

        // When
        viewModel.signIn()

        // Wait for async update
         await withCheckedContinuation { continuation in
             DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                 continuation.resume()
             }
         }

        // Then
        #expect(viewModel.user != nil, "User should be set after successful sign-in")
        #expect(viewModel.user?.id == testUser.id, "User ID should match")
        #expect(viewModel.user?.name == testUser.name, "User name should match")
        #expect(viewModel.user?.email == testUser.email, "User email should match")
    }

    @Test func testSignInFailure() async {
        // Given
        let testErrorMessage = "Failed to get credentials via Apple Sign In"
        mockAuthService.result = .failure(
            NSError(
                domain: "SignIn",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: testErrorMessage
                ]
            )
        )

        // When
        viewModel.signIn()

        // Wait for async update
         await withCheckedContinuation { continuation in
             DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                 continuation.resume()
             }
         }

        // Then
        #expect(viewModel.errorMessage != nil, "Error message should be set on sign-in failure")
        #expect(viewModel.errorMessage == testErrorMessage, "Error message should be equal to test error message")
    }

    @Test func testSignInLoadingState() async {
        // Given
        let testUser = UserModel(
            id: "12345",
            name: "Test User",
            email: "test@example.com"
        )
        mockAuthService.result = .success(testUser)

        // When
        viewModel.signIn()

        // Then
        #expect(viewModel.isLoading == true, "Loading state should be true while signing in")

        // Wait for async update
         await withCheckedContinuation { continuation in
             DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                 continuation.resume()
             }
         }

        // Then
        #expect(viewModel.isLoading == false, "Loading state should be false after signing in")
    }
}
