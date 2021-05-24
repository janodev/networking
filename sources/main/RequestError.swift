import Foundation

public enum RequestError<T>: Error, CustomDebugStringConvertible {

    case error(Error)
    case expectedHTTPResponse(URLResponse?)
    case expectedNonEmptyContent
    case httpStatusError(Int)
    case invalidEndpoint(Resource<T>, URL)
    case jsonDecodingError(DecodingError, Data?, Decodable.Type)
    case timeout(TimeInterval)
    case wrongContentType(expected: String, actual: String?)

    var localizedDescription: String {
        let desc = i18nString(self).localizedDescription
        switch self {
        case .httpStatusError(let code): return "\(desc) Status: \(code)"
        default: return desc
        }
    }

    private func i18nString(_ error: RequestError) -> i18n {
        switch self {
        case .error: return .error
        case .expectedHTTPResponse: return .expectedHTTPResponse
        case .expectedNonEmptyContent: return .expectedNonEmptyContent
        case .httpStatusError: return .httpStatusError
        case .invalidEndpoint: return .invalidEndpoint
        case .jsonDecodingError: return .jsonDecodingError
        case .timeout: return .timeout
        case .wrongContentType: return .wrongContentType
        }
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        debugDescription
    }

    // MARK: - CustomDebugStringConvertible

    public var debugDescription: String {
        switch self {
        case let .jsonDecodingError(decodingError, offendingJSON, intendedType):
            return Self.describe(decodingError, offendingJSON, intendedType)
        case let .wrongContentType(expected: expected, actual: actual):
            return String(format: "%@ %@",
                          i18n.wrongContentType.localizedDescription,
                          "Expected: \"\(expected)\", actual: \"\(actual ?? "nil")\".")
        default:
            return localizedDescription
        }
    }

    private static func describe(
        _ decodingError: DecodingError,
        _ offendingJSON: Data?,
        _ intendedType: Decodable.Type) -> String
    {
        let errorMessage = "\(decodingError)"
            .components(separatedBy: "Swift.DecodingError.Context")
            .joined(separator: "\n       Swift.DecodingError.Context")
            .components(separatedBy: ", debugDescription:")
            .joined(separator: ",\n       debugDescription:")
        let prettyJson = offendingJSON?.toJSONString() ?? ""
        return """
            Error decoding. Details follow...
            Decodable type: \(intendedType)
            Error: \(errorMessage)
            JSON contents: \n\(prettyJson)
            """
    }
}
