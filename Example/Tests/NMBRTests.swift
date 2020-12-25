import XCTest
import nmbr

final class NMBRTests: XCTestCase {

    func testSmallNumber_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.precision = 0
        formatter.outputFormat = .short

        XCTAssertEqual("0", formatter.format(0))
        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("999", formatter.format(999))
    }

    func testLargeNumber_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.precision = 0
        formatter.outputFormat = .short

        XCTAssertEqual("1K", formatter.format(1000))
        XCTAssertEqual("1.1K", formatter.format(1100))
    }

    func testSmallNumber_ZH() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "zh")
        formatter.precision = 0
        formatter.outputFormat = .short

        XCTAssertEqual("0", formatter.format(0))
        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("999", formatter.format(999))
        XCTAssertEqual("9999", formatter.format(9999))
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
