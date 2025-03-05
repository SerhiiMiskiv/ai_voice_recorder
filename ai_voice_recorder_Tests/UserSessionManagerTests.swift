//
//  UserSessionManagerTests.swift
//  ai_voice_recorder_Tests
//
//  Created by Serhii Miskiv on 03.03.2025.
//

import Testing
@testable import ai_voice_recorder

@Suite struct UserSessionManagerTests {
    var sessionManager: UserSessionManager!

    init() {
        sessionManager = UserSessionManager.shared
    }
    
    private func clearUserSession() {
        sessionManager.clear()
    }

    @Test func testSavingUser() {
        // When
        clearUserSession()
        let testUser = UserModel(
            id: "1",
            name: "Test Name",
            email: "test@email.com"
        )
        sessionManager.save(testUser)
        let retrievedUser = sessionManager.getLoggedUser()

        // Then
        #expect(retrievedUser != nil, "Retrieved user should not be nil")
        #expect(retrievedUser?.id == testUser.id, "Retrieved id should match the saved id")
        #expect(retrievedUser?.name == testUser.name, "Retrieved name should match the saved name")
        #expect(retrievedUser?.email == testUser.email, "Retrieved email should match the saved email")
    }

    @Test func testNotSavedUser() {
        // When
        clearUserSession()
        let retrievedUser = sessionManager.getLoggedUser()

        // Then
        #expect(retrievedUser == nil, "Non-saved user should return nil")
    }

    @Test func testSavedUserAndClearedPreferences() {
        // Given
        clearUserSession()
        let testUser = UserModel(
            id: "1",
            name: "Test Name",
            email: "test@email.com"
        )
        sessionManager.save(testUser)

        // When
        sessionManager.clear()
        let retrievedUser = sessionManager.getLoggedUser()

        // Then
        #expect(retrievedUser == nil, "Retrieved user after UserSessionManager.clear() should be nil")
    }
}
