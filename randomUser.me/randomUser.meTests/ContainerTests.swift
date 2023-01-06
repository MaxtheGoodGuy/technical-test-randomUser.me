//
//  ContainerTests.swift
//  randomUser.meTests
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

import XCTest
import Nimble
@testable import randomUser_me

private protocol MockDependanceProtocol: AnyObject {}

private final class MockDependance: MockDependanceProtocol {}

final class ContainerTests: XCTestCase {
    override func tearDown() {
        super.tearDown()

        Container.reset()
    }

    func test_registerResolve_sameInstance() {
        // Given
        let mockDependance = MockDependance()

        // When
        Container.register(MockDependanceProtocol.self, mockDependance)
        let resolvedContainer: MockDependanceProtocol = Container.resolve()

        // Then
        expect(resolvedContainer === mockDependance).to(beTrue())
    }

    func test_registerResolve_multipletInstances() {
        // Given

        // When
        Container.register(MockDependanceProtocol.self, MockDependance())
        let firstResolvedContainer: MockDependanceProtocol = Container.resolve()
        let secondResolvedContainer: MockDependanceProtocol = Container.resolve()

        // Then
        expect(firstResolvedContainer === secondResolvedContainer).to(beFalse())
    }

    func test_resolve_fails() {
        // Given

        // When

        // Then
        expect { _ = Container.resolve() as MockDependanceProtocol}.to(throwAssertion())
    }
}
