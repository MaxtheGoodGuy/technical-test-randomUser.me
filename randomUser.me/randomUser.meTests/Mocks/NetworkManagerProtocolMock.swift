//
//  NetworkManagerProtocolMock.swift
//  randomUser.meTests
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

@testable import randomUser_me
import RxSwift

// MARK: - Generated using Sourcery
final class NetworkManagerProtocolMock: NetworkManagerProtocol {

    // MARK: - requestRandomUsers

    var requestRandomUsersAmountCallsCount = 0
    var requestRandomUsersAmountCalled: Bool {
        return requestRandomUsersAmountCallsCount > 0
    }
    var requestRandomUsersAmountReceivedAmount: Int?
    var requestRandomUsersAmountReceivedInvocations: [Int] = []
    var requestRandomUsersAmountReturnValue: Single<[User]>!
    var requestRandomUsersAmountClosure: ((Int) -> Single<[User]>)?

    func requestRandomUsers(amount: Int) -> Single<[User]> {
        requestRandomUsersAmountCallsCount += 1
        requestRandomUsersAmountReceivedAmount = amount
        requestRandomUsersAmountReceivedInvocations.append(amount)
        return requestRandomUsersAmountClosure.map({ $0(amount) }) ?? requestRandomUsersAmountReturnValue
    }
}
