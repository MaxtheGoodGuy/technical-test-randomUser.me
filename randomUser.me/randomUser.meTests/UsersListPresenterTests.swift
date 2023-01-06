//
//  UsersListPresenterTests.swift
//  randomUser.meTests
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

import RxSwift
import XCTest
import Nimble
@testable import randomUser_me

final class UsersListPresenterTests: XCTestCase {
    private let mockUsers: [User] = [
        .init(name: .init(first: "first1", last: "last1"),
              email: "email1"),
        .init(name: .init(first: "first2", last: "last2"),
              email: "email2"),
        .init(name: .init(first: "first3", last: "last3"),
              email: "email3"),
        .init(name: .init(first: "first4", last: "last4"),
              email: "email4")
    ]

    private var presenter: UsersListPresenter!
    private var mockView: UsersListViewProtocolMock!
    private var coreDataManagerMock: CoreDataManagerProtocolMock!
    private var networkManagerMock: NetworkManagerProtocolMock!

    override func setUp() {
        super.setUp()

        coreDataManagerMock = CoreDataManagerProtocolMock()
        networkManagerMock = NetworkManagerProtocolMock()

        Container.register(CoreDataManagerProtocol.self, self.coreDataManagerMock)
        Container.register(NetworkManagerProtocol.self, self.networkManagerMock)

        mockView = UsersListViewProtocolMock()
        presenter = .init(view: mockView)
    }

    override func tearDown() {
        super.tearDown()

        Container.reset()
    }

    func test_viewDidLoad() throws {
        // Given
        networkManagerMock.requestRandomUsersAmountReturnValue = .just(mockUsers)

        // When
        presenter.viewDidLoad()

        // Then
        expect(self.mockView.setupWithCalled).toEventually(beTrue())
        expect(self.mockView.setupWithReceivedData?.headerTitle).toEventually(equal("randomUser.me"))
        expect(self.mockView.startRefreshingCalled).toEventually(beTrue())
        expect(self.networkManagerMock.requestRandomUsersAmountCalled).toEventually(beTrue())
        expect(self.mockView.refreshWithCalled).toEventually(beTrue())
        expect(self.mockView.refreshWithReceivedUsers).toEventually(equal(mockUsers))
        expect(self.coreDataManagerMock.saveUsersUsersCalled).toEventually(beTrue())
        expect(self.mockView.configureWithCalled).toEventually(beTrue())
        expect(self.mockView.configureWithReceivedData?.headerSubtitle).toEventually(equal("Amount of users loaded: \(mockUsers.count)"))
        expect(self.mockView.endRefreshingCalled).toEventually(beTrue())
    }

    func test_fetchMoreRandomUsers() throws {
        // Given
        networkManagerMock.requestRandomUsersAmountReturnValue = .just(mockUsers)

        // When
        presenter.fetchMoreRandomUsers()

        // Then
        expect(self.mockView.startRefreshingCalled).toEventually(beTrue())
        expect(self.networkManagerMock.requestRandomUsersAmountCalled).toEventually(beTrue())
        expect(self.mockView.appendNewUsersCalled).toEventually(beTrue())
        expect(self.mockView.appendNewUsersReceivedUsers).toEventually(equal(mockUsers))
        expect(self.coreDataManagerMock.saveUsersUsersCalled).toEventually(beTrue())
        expect(self.mockView.configureWithCalled).toEventually(beTrue())
        expect(self.mockView.configureWithReceivedData?.headerSubtitle).toEventually(equal("Amount of users loaded: \(mockUsers.count)"))
        expect(self.mockView.endRefreshingCalled).toEventually(beTrue())
    }

    func test_fetchMoreRandomUsers_after_viewDidLoad() throws {
        // Given
        networkManagerMock.requestRandomUsersAmountReturnValue = .just(mockUsers)

        // When
        presenter.viewDidLoad()
        presenter.fetchMoreRandomUsers()

        // Then
        expect(self.mockView.startRefreshingCalled).toEventually(beTrue())
        expect(self.networkManagerMock.requestRandomUsersAmountCalled).toEventually(beTrue())
        expect(self.mockView.appendNewUsersCalled).toEventually(beTrue())
        expect(self.mockView.appendNewUsersReceivedUsers).toEventually(equal(mockUsers))
        expect(self.coreDataManagerMock.saveUsersUsersCalled).toEventually(beTrue())
        expect(self.mockView.configureWithCalled).toEventually(beTrue())
        expect(self.mockView.configureWithReceivedData?.headerSubtitle)
            .toEventually(equal("Amount of users loaded: \(mockUsers.count * 2)"))
        expect(self.mockView.endRefreshingCalled).toEventually(beTrue())
    }

    func test_viewDidLoad_network_failure() throws {
        // Given
        let expectedError = AppError.networkError("network is unreachable")
        networkManagerMock.requestRandomUsersAmountReturnValue = .error(expectedError)
        coreDataManagerMock.loadUsersReturnValue = mockUsers

        // When
        presenter.viewDidLoad()

        // Then
        expect(self.mockView.startRefreshingCalled).toEventually(beTrue())
        expect(self.networkManagerMock.requestRandomUsersAmountCalled).toEventually(beTrue())
        expect(self.coreDataManagerMock.loadUsersCalled).toEventually(beTrue())
        expect(self.mockView.refreshWithCalled).toEventually(beTrue())
        expect(self.mockView.refreshWithReceivedUsers).toEventually(equal(mockUsers))
        expect(self.mockView.endRefreshingCalled).toEventually(beTrue())
    }
}
