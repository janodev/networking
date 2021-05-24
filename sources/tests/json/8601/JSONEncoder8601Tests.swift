
import Foundation
@testable import Networking
import XCTest

final class JSONEncoder8601Tests: XCTestCase
{
    private struct D: Encodable {
        let d: Date
    }

    private var dateComponents: DateComponents {
        var components = DateComponents()
        components.year = 2021
        components.month = 01
        components.day = 01
        components.hour = 01
        components.minute = 01
        components.second = 01
        return components
    }

    private var date: Date {
        Calendar(identifier: .gregorian).date(from: dateComponents)!
    }

    func testEncode8601() throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.iso8601withFractionalSeconds
        let data = try encoder.encode(D(d: date))
        guard let string = String(data: data, encoding: .utf8) else {
            XCTFail("Failed to encode date as String")
            return
        }
        XCTAssertEqual(string, "{\"d\":\"2021-01-01T00:01:01.000Z\"}")
    }
}
