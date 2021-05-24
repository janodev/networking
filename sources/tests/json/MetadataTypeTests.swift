@testable import Networking
import XCTest

final class MetadataTypeTests: XCTestCase
{
    private let data = """
    {
        "a": 1,
        "b": 0.1,
        "c": "one"
    }
    """.data(using: .utf8)!

    func testDecodeNonOptionalProperties()
    {
        struct Some: Decodable {
            let a, b, c: MetadataType
        }
        let some = try! JSONDecoder().decode(Some.self, from: data)
        XCTAssertEqual(some.a.value as! Int, 1)
        XCTAssertEqual(some.b.value as! Double, 0.1)
        XCTAssertEqual(some.c.value as! String, "one")
    }

    func testDecodeToOptionalProperties()
    {
        struct Opt: Decodable {
            let a, b, c: MetadataType?
        }
        let some = try! JSONDecoder().decode(Opt.self, from: data)
        XCTAssertEqual(some.a?.value as! Int, 1)
        XCTAssertEqual(some.b?.value as! Double, 0.1)
        XCTAssertEqual(some.c?.value as! String, "one")
    }

    func testDecodeEmptyJSON()
    {
        struct Opt: Decodable {
            let a, b, c: MetadataType?
        }
        let data = "{}".data(using: .utf8)!
        let some = try! JSONDecoder().decode(Opt.self, from: data)
        XCTAssertEqual(some.a?.value as? Int, nil)
        XCTAssertEqual(some.b?.value as? Double, nil)
        XCTAssertEqual(some.c?.value as? String, nil)
    }
}
