//
//  InjectTests.swift
//  randomUser.meTests
//
//  Created by Maximilien Oteifeh--Pfennig on 26/09/2022.
//

import XCTest
@testable import randomUser_me

private protocol MockDependanceProtocol: AnyObject {}

private final class MockDependance: MockDependanceProtocol {}

private final class View {
    @Inject var mockDependance: MockDependanceProtocol
}

final class InjectTests: XCTestCase {
    override func tearDown() {
        super.tearDown()

        Container.reset()
    }

    func test_container_isResolved() {
        // Given
        let mockDependance = MockDependance()
        Container.register(MockDependanceProtocol.self, mockDependance)

        // When
        let view = View()

        // Then
        XCTAssertTrue(view.mockDependance === mockDependance)
    }

    func test_container_isCached() {
        // Given
        Container.register(MockDependanceProtocol.self, MockDependance())

        // When
        let view = View()

        // Then
        XCTAssertTrue(view.mockDependance === view.mockDependance)
    }
}
