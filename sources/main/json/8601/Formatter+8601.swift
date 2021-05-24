import Foundation

public extension Formatter
{
    static let iso8601 = configure(ISO8601DateFormatter()) {
        $0.formatOptions = [.withInternetDateTime]
    }
    static let iso8601withFractionalSeconds = configure(ISO8601DateFormatter()) {
        $0.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    }
}
