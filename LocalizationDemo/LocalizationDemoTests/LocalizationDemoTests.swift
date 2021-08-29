import XCTest
@testable import LocalizationDemo
import SwiftUI

class LocalizationDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // XCTAssertEqual(LocalizedStringKey("hello").stringValue(), "hello!")
        XCTAssertEqual(LocalizedStringKey("hello").stringValue(locale: Locale(identifier: "en")), "hello!")
        XCTAssertEqual(LocalizedStringKey("hello").stringValue(locale: Locale(identifier: "zh-Hant")), "你好")
        XCTAssertEqual(LocalizedStringKey("hello").stringValue(locale: Locale(identifier: "ja")), "hello")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
