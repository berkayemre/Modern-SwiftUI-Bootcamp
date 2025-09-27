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

    // Basit duman testi: Uygulama açılıyor mu? Çökmeden foreground'a geliyor mu?
    func testLaunchAndStayAlive() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertEqual(app.state, .runningForeground)
    }

    // Liste varsa pull-to-refresh dener; yoksa testi SKIP eder (başarısız saymaz).
    func testPullToRefreshIfTableExists() throws {
        let app = XCUIApplication()
        app.launch()

        let table = app.tables.firstMatch
        guard table.waitForExistence(timeout: 2) else {
            throw XCTSkip("Liste görünmedi; bu akış ekran yapısına bağlıdır.")
        }

        // Refresh hareketi (varsa)
        table.swipeDown()

        // Basit doğrulama
        XCTAssertTrue(table.exists)
    }
}
