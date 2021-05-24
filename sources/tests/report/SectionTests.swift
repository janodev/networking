import XCTest
@testable import Networking

final class SectionTests: XCTestCase {

    func test_section_init_title_emptyContent() {
        // when content is empty instance is nil
        XCTAssert(ReportSection(content: "", title: "abc") == nil)
    }

    func test_section_init_emptyContent() {
        // when content is empty instance is nil
        XCTAssert(ReportSection(content: "") == nil)
    }
}
