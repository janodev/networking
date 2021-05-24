@testable import Networking
import XCTest

final class ReportTests: XCTestCase
{
    private static let url = URL(string: "https://domain.com/api?1=2")!
    private static let request: URLRequest = {
        var request = URLRequest(url: url)
        ["Accept" : "*/*"].forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }()
    private static let response = HTTPURLResponse(
        url: url,
        statusCode: 200,
        httpVersion: "HTTP/2",
        headerFields: [
            "content-type": "application/json; charset=utf-8"
        ])

    func testNoResponseOrError() {
        let string = Report(request: Self.request,
                            response: nil,
                            error: nil,
                            data: nil).report()
        XCTAssertEqual(string, """
        ??? GET https://domain.com/api?1=2
        Request
         ├─ Headers
         │ Accept = */*
        Response
         ├─ Headers
         │ <no response>
         └
        """)
    }

    func testError() {
        let error = RequestError<String>.httpStatusError(401)
        let string = Report(request: Self.request,
                            response: nil,
                            error: error,
                            data: nil).report()
        XCTAssertEqual(string, """
        ??? GET https://domain.com/api?1=2
        Request
         ├─ Headers
         │ Accept = */*
        Response
         ├─ Headers
         │ <no response>
         ├─ Error
         │ HTTP status error. Status: 401
         └
        """)
    }

    func testResponse() {
        let string = Report(request: Self.request,
                            response: Self.response,
                            error: nil,
                            data: nil).report()
        XCTAssertEqual(string, """
        200 GET https://domain.com/api?1=2
        Request
         ├─ Headers
         │ Accept = */*
        Response
         ├─ Headers
         │ Content-Type = application/json; charset=utf-8
         └
        """)
    }

    func testResponseError() {
        let error = RequestError<String>.httpStatusError(401)
        let string = Report(request: Self.request,
                            response: Self.response,
                            error: error,
                            data: nil).report()
        XCTAssertEqual(string, """
        200 GET https://domain.com/api?1=2
        Request
         ├─ Headers
         │ Accept = */*
        Response
         ├─ Headers
         │ Content-Type = application/json; charset=utf-8
         ├─ Error
         │ HTTP status error. Status: 401
         └
        """)
    }

    func testFormat() {
        let error = RequestError<String>.httpStatusError(401)
        let string = Report(request: Self.request,
                            response: Self.response,
                            error: error,
                            data: "abc".data(using: .utf8)).report()
        log.debug("\(string)")
    }
}
