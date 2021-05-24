import XCTest
@testable import Networking

final class LogBuilderTests: XCTestCase
{
    func testSection()
    {
        @LogBuilder
        func format() -> String {
            ReportSection(content: """
            Accept: */*
            User-Agent: curl/7.64.1
            """, title: "Headers")
        }
        XCTAssertEqual(format(), """
         ├─ Headers
         │ Accept: */*
         │ User-Agent: curl/7.64.1
         └
        """)
    }

    func testEmptySection()
    {
        @LogBuilder
        func format() -> String {
            ReportSection(content: "", title: "Headers")
        }
        XCTAssertEqual(format(), "", "Empty section should be discarded.")
    }
}
