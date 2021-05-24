@testable import Networking
import Session
import XCTest

final class ClientTests: XCTestCase
{
    // https://randomuser.me/api/?results=1&inc=name&seed=abc
    func testRequestJSON()
    {
        guard let session = mockSession else {
            XCTFail("Missing file oneRandomUser.json")
            return
        }
        let exp = XCTestExpectation(description: "network request completes within 3 seconds")
        let client = Client(baseURL: baseURL, session: session)
        let requestJSON: Resource<Response> = .jsonResource()
            .path("api/")
            .addQueryItems([
                URLQueryItem(name: "results", value: "1"),
                URLQueryItem(name: "inc", value: "name"),
                URLQueryItem(name: "seed", value: "abc")
            ])
        client.request(resource: requestJSON) { result in
            switch result {
            case let .failure(error): XCTFail("\(error)")
            case .success: ()
            }
            exp.fulfill()
        }
        XCTWaiter().wait(for: [exp], timeout: TimeInterval(3))
    }

    // MARK: - Text

    // https://randomuser.me/api/?results=1&inc=name&seed=abc
    func testRequestText()
    {
        guard let session = mockSession else {
            XCTFail("Missing file oneRandomUser.json")
            return
        }
        let client = Client(baseURL: baseURL, session: session)
        let requestText: Resource<String?> = .textPlainResource()
            .path("api/")
            .addQueryItems([
                URLQueryItem(name: "results", value: "1"),
                URLQueryItem(name: "inc", value: "name"),
                URLQueryItem(name: "seed", value: "abc")
            ])
        let exp = XCTestExpectation(description: "network request completes within 3 seconds")
        client.request(resource: requestText) { result in
            switch result {
            case .failure(let error): XCTFail("Error: \(error)")
            case .success: ()
            }
            exp.fulfill()
        }
        XCTWaiter().wait(for: [exp], timeout: TimeInterval(3))
    }

    // MARK: - private

    private var mockSession: Session? {
        let response = HTTPURLResponse(
            url: baseURL,
            statusCode: 200,
            httpVersion: "HTTP/2",
            headerFields: responseHeaders
        )
        guard let url = Bundle.module.url(forResource: "oneRandomUser", withExtension: "json"),
              let jsonData = try? Data(contentsOf: url) else {
            return nil
        }
        return JSONSessionStub(data: jsonData, response: response, error: nil)
    }

    private let baseURL = URL(string: "https://randomuser.me/")!

    private var responseHeaders: [String: String] = [
        "Access-Control-Allow-Origin": "*",
        "Alt-Svc": "h3-27=\":443\"; ma=86400, h3-28=\":443\"; ma=86400, h3-29=\":443\"; ma=86400",
        "Cache-Control": "no-cache",
        "cf-cache-status": "DYNAMIC",
        "cf-ray": "650690b97bb1ce6b-LHR",
        "cf-request-id": "0a17f8c7ea0000ce6b74b7b000000001",
        "Content-Encoding": "br",
        "Content-Type": "application/json; charset=utf-8",
        "Date": "Sun, 16 May 2021 18:10:53 GMT",
        "Etag": "W/\"82-lV0prFHU/l7BlWGu5VmzIhRMy1E\"",
        "expect-ct": "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\"",
        "nel": "{\"report_to\":\"cf-nel\",\"max_age\":604800}",
        "report-to": "{\"endpoints\":[{\"url\":\"https:\\/\\/a.nel.cloudflare.com\\/report?s=SqjFMHqQruPrNHv0BzrYU8ZqjRIbfHGBQtxPWI0cdCyX7h6mKzdR8JkSG9BfxfU%2Be35DRDY5WFlSIX6wWn44A33oELqWsDoxS2iwOEQH\"}],\"group\":\"cf-nel\",\"max_age\":604800}",
        "Server": "cloudflare",
        "Vary": "Accept-Encoding",
        "x-powered-by": "Express"
    ]
}
