@testable import RandomuserApi
import Networking
import Session
import XCTest

final class NetworkSmokeTests: XCTestCase
{    
    func testPagination() {
        let api = RandomUserApi(session: URLSession(configuration: URLSessionConfiguration.ephemeral))
        let exp = expectation(description: "Run request.")
        api.page(page: 0, pageSize: 2) { result in
            switch result {
            case .failure(let error):
                log.error("\(error)")
                // not asserting because the network is not under our control
            case .success(let response):
                print("\(response)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
    }
}
