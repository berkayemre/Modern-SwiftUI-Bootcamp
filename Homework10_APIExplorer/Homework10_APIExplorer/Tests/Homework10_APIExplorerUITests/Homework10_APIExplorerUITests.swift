//
//  Homework10_APIExplorerUITests.swift
//  Homework10_APIExplorerUITests
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import XCTest

final class Homework10_APIExplorerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchAndStayAlive() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertEqual(app.state, .runningForeground)
    }

    func testPullToRefreshIfTableExists() throws {
        let app = XCUIApplication()
        app.launch()

        let table = app.tables.firstMatch
        guard table.waitForExistence(timeout: 2) else {
            throw XCTSkip("Liste görünmedi; bu akış ekran yapısına bağlıdır.")
        }

        table.swipeDown()

        XCTAssertTrue(table.exists)
    }
}
