@testable import RandomuserApi
import XCTest

final class DecodeTests: XCTestCase {

    // curl -v "https://randomuser.me/api/1.3/" | python -mjson.tool > singleUser.json
    func testSingleUser() throws {
        _ = try parseFull8601(filename: "singleUser.json") as Response
    }
    
    // curl -v "https://randomuser.me/api/?page=3&results=10&seed=abc" | python -mjson.tool > pagination.json
    func testPagination() throws {
        _ = try parseFull8601(filename: "pagination.json") as Response
    }
    
    // curl -v "https://randomuser.me/api/?results=10" | python -mjson.tool > tenResults.json
    func testTenResults() throws {
        _ = try parseFull8601(filename: "tenResults.json") as Response
    }
    
    // curl -v "https://randomuser.me/api/?page=0&results=2" | python -mjson.tool > tenResults.json
    func testTwoResults() throws {
        _ = try parseFull8601(filename: "twoResults.json") as Response
    }
}
