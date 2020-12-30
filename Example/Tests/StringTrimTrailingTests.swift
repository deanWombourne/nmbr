//
//  StringTrimTrailingTests.swift
//  nmbr_Tests
//
//  Created by Sam Dean on 30/12/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import XCTest

@testable import nmbr

final class StringTrimTrailingTests: XCTestCase {

    func testEmptyString() {
        XCTAssertEqual("".trimTrailing(), "")
    }

    func testInteger() {
        XCTAssertEqual("123".trimTrailing(), "123")
    }

    func testTrimsTrailingDecimal() {
        XCTAssertEqual("123.".trimTrailing(decimalSeparator: "."), "123")
    }

    func testTrimsZeros() {
        XCTAssertEqual("123.100".trimTrailing(decimalSeparator: "."), "123.1")
    }

    func testTrimsZerosAndTrailingDecimal() {
        XCTAssertEqual("123.000".trimTrailing(decimalSeparator: "."), "123")
    }

    func testStopsTrimmingAtDecimal() {
        XCTAssertEqual("120.000".trimTrailing(decimalSeparator: "."), "120")
    }
}
