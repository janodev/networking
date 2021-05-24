@testable import RandomuserApi
import Networking
import XCTest

final class ParametersTests: XCTestCase {

    private let baseURL = RandomUserApi.BaseURL.current
    
    func testDefaultParameters() {
        let expected = baseURL.absoluteString
        let parameters = Parameters()
        XCTAssert(parameters, expected)
    }
    
    func testPagination() {
        let expected = "https://randomuser.me/api/?page=0&results=10&seed=abc"
        let parameters = Parameters(results: .pagination(Pagination(page: 0, resultsPerPage: 10)), seed: "abc")
        XCTAssert(parameters, expected)
    }
    
    func testTenResults() {
        let expected = "https://randomuser.me/api/?results=10"
        let parameters = Parameters(results: .numberOfResults(10))
        XCTAssert(parameters, expected)
    }
    
    private func createURL(_ parameters: Parameters) -> URL? {
        let queryItems = URLQueryItemFactory.queryItems(parameters: parameters)
        let resource: Resource<Response> = .jsonResource().addQueryItems(queryItems)
        let request = URLRequest(resource: resource, baseURL: baseURL)
        return request?.url
    }
    
    private func XCTAssert(_ parameters: Parameters,
                           _ expected: String,
                           file: StaticString = #filePath,
                           line: UInt = #line) {
        guard let url = createURL(parameters)?.absoluteString else {
            XCTFail("Failed to create tn URL from parameters: \(parameters)")
            return
        }
        XCTAssertEqual(url, expected, file: file, line: line)
    }
}
