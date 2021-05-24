@testable import Networking
import XCTest

final class GenericJSONDecoderTests: XCTestCase
{
    private struct Beer: Decodable {
        let name: String
    }

    func testDecode()
    {
        let data = """
        {
            "name": "estrella"
        }
        """.data(using: .utf8)!
        let result: Result<Beer,Error> = GenericJSONDecoder().decode(data)
        XCTAssertEqual(try result.get().name, "estrella")
    }

    func testPrettyDecodingError()
    {
        let data = "".data(using: .utf8)!
        let result: Result<Beer,Error> = GenericJSONDecoder().decode(data)
        guard case let .failure(error) = result, error is PrettyDecodingError else {
            XCTFail("Failing to parse an object should return a PrettyDecodingError.")
            return
        }
    }
}
