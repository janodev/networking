import Foundation

/**
 Slightly more readable DecodingError.

 The description will look like this:
 ```
 [networking] PrettyDecodingErrorTests.te…: 17 · Error decoding. Details follow...
 Decodable type: Beer
 Error: keyNotFound(CodingKeys(stringValue: "name", intValue: nil),
        Swift.DecodingError.Context(codingPath: [],
        debugDescription: "No value associated with key CodingKeys(stringValue: \"name\", intValue: nil) (\"name\").", underlyingError: nil))
 JSON contents:
 {

 }
 ```
 */
struct PrettyDecodingError: Error, CustomStringConvertible
{
    let error: DecodingError
    let offendingJSON: Data?
    let intendedType: Decodable.Type

    init(_ error: DecodingError, offendingJSON: Data?, intendedType: Decodable.Type) {
        self.error = error
        self.offendingJSON = offendingJSON
        self.intendedType = intendedType
    }

    var description: String {
        let errorMessage = "\(error)"
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
