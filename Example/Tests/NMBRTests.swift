import XCTest
import nmbr

final class NMBRTests: XCTestCase {

    // MARK: Small numbers (i.e. less than the first grouping separator)

    func testSmallNumber_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.outputFormat = .short

        XCTAssertEqual("0", formatter.format(0))
        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("999", formatter.format(999))
    }

    func testSmallNumber_India() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_IN")
        formatter.outputFormat = .short

        XCTAssertEqual("0", formatter.format(0))
        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("999", formatter.format(999))
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

    // MARK: Long numbers (greater or equal to the first grouping separator)

    func testLargeNumber_Long_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.outputFormat = .long

        XCTAssertEqual("1 thousand", formatter.format(1000))
        XCTAssertEqual("1.1 thousand", formatter.format(1100))

        XCTAssertEqual("1 million", formatter.format(1_000_000))
        XCTAssertEqual("1 billion", formatter.format(1_000_000_000))
        XCTAssertEqual("1 trillion", formatter.format(1_000_000_000_000))
    }

    func testVeryLargeNumber_Short_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.outputFormat = .short

        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("1K", formatter.format(1_000))
        XCTAssertEqual("1M", formatter.format(1_000_000))
        XCTAssertEqual("1B", formatter.format(1_000_000_000))
        XCTAssertEqual("1T", formatter.format(1_000_000_000_000))
    }

    func testVeryLargeNumber_Short_JP() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.outputFormat = .short

        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("1万", formatter.format(10_000))
        XCTAssertEqual("1億", formatter.format(100_000_000))
        XCTAssertEqual("1兆", formatter.format(1_000_000_000_000))
    }

    func testTooLargeNumber_Short_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.outputFormat = .short

        // See what happens if the number is past the highest named group in the strings dict
        XCTAssertEqual("1000T", formatter.format(1_000_000_000_000_000))
    }

    func testLargeNumber_Short_UK() {
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.outputFormat = .short

        XCTAssertEqual("1K", formatter.format(1000))
        XCTAssertEqual("1.1K", formatter.format(1100))
    }
}

final class NMBRPrecisionTests: XCTestCase {

    func testSmallNumbers() {
        let formatter = NMBRFormatter()
        formatter.precision = 2

        XCTAssertEqual("1", formatter.format(1))
        XCTAssertEqual("1", formatter.format(1.0))
        XCTAssertEqual("1.1", formatter.format(1.1))
        XCTAssertEqual("1.12", formatter.format(1.12))
        XCTAssertEqual("1.12", formatter.format(1.123))
        XCTAssertEqual("1.12", formatter.format(1.1234))
    }

    func testLargeNumbers() {
        let formatter = NMBRFormatter()
        formatter.precision = 1

        XCTAssertEqual("1K", formatter.format(1000))
        XCTAssertEqual("1.1K", formatter.format(1100))
        XCTAssertEqual("1.1K", formatter.format(1110))
        XCTAssertEqual("1.1K", formatter.format(1149))
        XCTAssertEqual("1.2K", formatter.format(1151))
    }
}

final class NSBRLocalisationTests: XCTestCase {

    func testFallbackLocalisations() {
        // Make sure that a fictional locale identifier doesn't crash the library
        let formatter = NMBRFormatter()
        formatter.locale = Locale(identifier: "aa_ZZ")

        // Should default back to "en"
        XCTAssertEqual("1K", formatter.format(1000))
    }
}
