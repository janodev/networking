import Foundation

/**
 A type to decode a JSON value that can be one of several possible types.

 You may decode this:
 ```
 {
   "a": 1,
   "b": 0.1,
   "c": "one"
 }
 ```
 To an object like this:
 ```
 struct O: Decodable {
     let a,b,c: MetadataType
 }
```
 */
public enum MetadataType: Codable {
    
    case int(Int)
    case double(Double)
    case string(String)

    var value: Any {
        switch self {
        case let .int(int): return int
        case let .double(double): return double
        case let .string(string): return string
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let int: MetadataType = try? .int(container.decode(Int.self)) {
            self = int
        } else if let double: MetadataType = try? .double(container.decode(Double.self)) {
            self = double
        } else if let string: MetadataType = try? .string(container.decode(String.self)) {
            self = string
        } else {
            throw DecodingError.typeMismatch(
                MetadataType.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Encoded payload not of an expected type"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let double):
            try container.encode(double)
        case .int(let int):
            try container.encode(int)
        case .string(let string):
            try container.encode(string)
        }
    }
}
