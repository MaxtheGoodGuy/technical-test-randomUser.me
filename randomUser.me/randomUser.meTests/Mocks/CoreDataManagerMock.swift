//
//  CoreDataManagerMock.swift
//  randomUser.meTests
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

@testable import randomUser_me

// MARK: - Generated using Sourcery
final class CoreDataManagerProtocolMock: CoreDataManagerProtocol {

    // MARK: - saveUsers

    var saveUsersUsersCallsCount = 0
    var saveUsersUsersCalled: Bool {
        return saveUsersUsersCallsCount > 0
    }
    var saveUsersUsersReceivedUsers: [User]?
    var saveUsersUsersReceivedInvocations: [[User]] = []
    var saveUsersUsersClosure: (([User]) -> Void)?

    func saveUsers(users: [User]) {
        saveUsersUsersCallsCount += 1
        saveUsersUsersReceivedUsers = users
        saveUsersUsersReceivedInvocations.append(users)
        saveUsersUsersClosure?(users)
    }

    // MARK: - loadUsers

    var loadUsersCallsCount = 0
    var loadUsersCalled: Bool {
        return loadUsersCallsCount > 0
    }
    var loadUsersReturnValue: [User]!
    var loadUsersClosure: (() -> [User])?

    func loadUsers() -> [User] {
        loadUsersCallsCount += 1
        return loadUsersClosure.map({ $0() }) ?? loadUsersReturnValue
    }
}
