/// Result of the attempt to understand and satisfy the HTTP request.
enum Status {

    case informational_1xx(Int)
    case successful_2xx(Int)
    case redirection_3xx(Int)
    case clientError_4xx(Int)
    case serverError_5xx(Int)

    init?(code: Int) {
        guard 100 ..< 600 ~= code else { return nil }
        switch code {
        case 100..<200: self = .informational_1xx(code)
        case 200..<300: self = .successful_2xx(code)
        case 300..<400: self = .redirection_3xx(code)
        case 400..<500: self = .clientError_4xx(code)
        case 500..<600: self = .serverError_5xx(code)
        default: return nil
        }
    }

    var code: Int {
        switch self {
        case .informational_1xx(let code): return code
        case .successful_2xx(let code): return code
        case .redirection_3xx(let code): return code
        case .clientError_4xx(let code): return code
        case .serverError_5xx(let code): return code
        }
    }

    var isError: Bool {
        switch self {
        case .clientError_4xx: return true
        case .serverError_5xx: return true
        default: return false
        }
    }

    /// Returns true when the status code is cacheable by default according to [RFC 7231 6.1](https://tools.ietf.org/html/rfc7231#section-6.1).
    var isDefaultCacheable: Bool {
        [200, 203, 204, 206, 300, 301, 404, 405, 410, 414, 501].contains(code)
    }
}
