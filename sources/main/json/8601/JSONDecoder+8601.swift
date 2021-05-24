import Foundation

/**
 Parses ISO 8601 date with format `yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX`.

 See [How to convert a date string with optional fractional seconds](https://stackoverflow.com/a/46458771/412916).
 */
public extension JSONDecoder.DateDecodingStrategy
{    
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.iso8601withFractionalSeconds.date(from: string) ?? Formatter.iso8601.date(from: string) {
            return date
        }
        log.error("Failed to format \(string) as ISO8601.")
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
