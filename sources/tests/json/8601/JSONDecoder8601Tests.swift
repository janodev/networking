
import Foundation
import Log
@testable import Networking
import XCTest

final class JSONDecoder8601Tests: XCTestCase
{
    struct D: Decodable {
        let d: Date
    }

    func testDecode8601() throws {
        try [
            "{ \"d\": \"2021-01-01T00:01:01.1Z\" }",
            "{ \"d\": \"2021-01-01T00:01:01.12Z\" }",
            "{ \"d\": \"2021-01-01T00:01:01.123Z\" }",
            "{ \"d\": \"2021-01-01T00:01:01.1234Z\" }",
            "{ \"d\": \"2021-01-01T00:01:01.12345Z\" }",
            "{ \"d\": \"2021-01-01T00:01:01.123456Z\" }",
            "{ \"d\": \"2021-01-01T00:01:01.1234567Z\" }"
        ].forEach { string in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601withFractionalSeconds
            let data = string.data(using: .utf8)!
            let date = try decoder.decode(D.self, from: data)
            log.debug("string: \(string), date: \(date)")
            XCTAssertNotNil("Failed to parse \(string)")
        }
    }
}
