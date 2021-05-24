import Foundation

enum i18n: String, CaseIterable
{
    case error
    case expectedHTTPResponse
    case expectedNonEmptyContent
    case httpStatusError
    case invalidEndpoint
    case jsonDecodingError
    case timeout
    case wrongContentType

    var localizedDescription: String {
        switch self {
        case .error: return NSLocalizedString("error.error", tableName: nil, bundle: Bundle.module, value: "", comment: "")
        case .expectedHTTPResponse: return NSLocalizedString("error.expectedHTTPResponse", tableName: nil, bundle: Bundle.module, value: "", comment: "")
        case .expectedNonEmptyContent: return NSLocalizedString("error.expectedNonEmptyContent", tableName: nil, bundle: Bundle.module, value: "", comment: "")
        case .httpStatusError: return NSLocalizedString("error.httpStatusError", tableName: nil, bundle: Bundle.module, value: "", comment: "")
        case .invalidEndpoint: return NSLocalizedString("error.invalidEndpoint", tableName: nil, bundle: Bundle.module, value: "", comment: "")
        case .jsonDecodingError: return NSLocalizedString("error.jsonDecodingError", tableName: nil, bundle: Bundle.module, value: "", comment: "")
        case .timeout: return NSLocalizedString("error.timeout", tableName: nil, bundle: Bundle.module, value: "", comment: "")
        case .wrongContentType: return NSLocalizedString("error.wrongContentType", tableName: nil, bundle: Bundle.module, value: "", comment: "")
        }
    }
}
