//
//  UsersListViewProtocolMock.swift
//  randomUser.meTests
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

@testable import randomUser_me

// MARK: - Generated using Sourcery
final class UsersListViewProtocolMock: UsersListViewProtocol {

    // MARK: - setup

    var setupWithCallsCount = 0
    var setupWithCalled: Bool {
        return setupWithCallsCount > 0
    }
    var setupWithReceivedData: UserListViewData.Setup?
    var setupWithReceivedInvocations: [UserListViewData.Setup] = []
    var setupWithClosure: ((UserListViewData.Setup) -> Void)?

    func setup(with data: UserListViewData.Setup) {
        setupWithCallsCount += 1
        setupWithReceivedData = data
        setupWithReceivedInvocations.append(data)
        setupWithClosure?(data)
    }

    // MARK: - configure

    var configureWithCallsCount = 0
    var configureWithCalled: Bool {
        return configureWithCallsCount > 0
    }
    var configureWithReceivedData: UserListViewData.Configure?
    var configureWithReceivedInvocations: [UserListViewData.Configure] = []
    var configureWithClosure: ((UserListViewData.Configure) -> Void)?

    func configure(with data: UserListViewData.Configure) {
        configureWithCallsCount += 1
        configureWithReceivedData = data
        configureWithReceivedInvocations.append(data)
        configureWithClosure?(data)
    }

    // MARK: - refresh

    var refreshWithCallsCount = 0
    var refreshWithCalled: Bool {
        return refreshWithCallsCount > 0
    }
    var refreshWithReceivedUsers: [User]?
    var refreshWithReceivedInvocations: [[User]] = []
    var refreshWithClosure: (([User]) -> Void)?

    func refresh(with users: [User]) {
        refreshWithCallsCount += 1
        refreshWithReceivedUsers = users
        refreshWithReceivedInvocations.append(users)
        refreshWithClosure?(users)
    }

    // MARK: - appendNewUsers

    var appendNewUsersCallsCount = 0
    var appendNewUsersCalled: Bool {
        return appendNewUsersCallsCount > 0
    }
    var appendNewUsersReceivedUsers: [User]?
    var appendNewUsersReceivedInvocations: [[User]] = []
    var appendNewUsersClosure: (([User]) -> Void)?

    func appendNewUsers(_ users: [User]) {
        appendNewUsersCallsCount += 1
        appendNewUsersReceivedUsers = users
        appendNewUsersReceivedInvocations.append(users)
        appendNewUsersClosure?(users)
    }

    // MARK: - startRefreshing

    var startRefreshingCallsCount = 0
    var startRefreshingCalled: Bool {
        return startRefreshingCallsCount > 0
    }
    var startRefreshingClosure: (() -> Void)?

    func startRefreshing() {
        startRefreshingCallsCount += 1
        startRefreshingClosure?()
    }

    // MARK: - endRefreshing

    var endRefreshingCallsCount = 0
    var endRefreshingCalled: Bool {
        return endRefreshingCallsCount > 0
    }
    var endRefreshingClosure: (() -> Void)?

    func endRefreshing() {
        endRefreshingCallsCount += 1
        endRefreshingClosure?()
    }
}
