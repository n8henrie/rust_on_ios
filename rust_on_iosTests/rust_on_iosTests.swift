//
//  rust_on_iosTests.swift
//  rust_on_iosTests
//
//  Created by Nathan Henrie on 2022-09-22.
//

import XCTest
@testable import rust_on_ios

final class rust_on_iosTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let result = add_numbers(6, 7)
        XCTAssertEqual(result, 13)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
