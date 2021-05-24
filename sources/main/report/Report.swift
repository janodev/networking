import Foundation

/**
 Creates a report for a data task result.
 */
struct Report: CustomStringConvertible
{
    private let request: URLRequest
    private let response: HTTPURLResponse?
    private let error: Error?
    private let data: Data?

    /// Initializes the report with the result of a data task request.
    init(request: URLRequest, response: HTTPURLResponse?, error: Error?, data: Data?) {
        self.request = request
        self.response = response
        self.error = error
        self.data = data
    }

    @LogBuilder
    func report() -> String
    {
        summary
        "Request"
        ReportSection(content: requestHeaders, title: "Headers")
        "Response"
        ReportSection(content: responseHeaders, title: "Headers")
        ReportSection(content: dataDescription, title: "Body")
        ReportSection(content: errorDescription, title: "Error")

    }

    // MARK: - CustomStringConvertible

    var description: String {
        report()
    }

    // MARK: - Private

    private var errorDescription: String { error.flatMap { "\($0)" } ?? "" }
    private var status: String? { response?.statusCode.description ?? "???" }
    private var method: String? { request.httpMethod?.description }
    private var url: String? { request.url?.absoluteString }
    private var requestHeaders: String {
        let headers = format(request.allHTTPHeaderFields ?? [:])
        return headers.isEmpty ? "<no headers sent>" : headers
    }
    private var responseHeaders: String {
        guard let response = response else { return "<no response>" }
        let headers = format(response.allHeaderFields)
        return headers.isEmpty ? "<no headers returned>" : headers
    }
    private var dataDescription: String {
        guard let data = data else { return "" }
        return "\(data.count) bytes"
    }

    // Returns `200 GET https://domain.com/api?1=2`
    private var summary: String {
        let summary = [status, method, url]
            .compactMap { $0 }
            .joined(separator: " ")
        return summary.isEmpty ? "Can’t summarize the request" : summary
    }

    private func format(_ headers: [AnyHashable: Any]) -> String {
        headers
            .compactMap { key, value in "\(key) = \(value)" }
            .sorted(by: { $0.lowercased() < $1.lowercased() })
            .joined(separator: "\n")
    }
}
