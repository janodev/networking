import Foundation
import Log

/**
 Decodes JSON to a generic decodable type.
 */
struct GenericJSONDecoder
{
    var dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601withFractionalSeconds

    func decode<T: Decodable>(_ data: Data) -> Result<T, Error>
    {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            let object = try decoder.decode(T.self, from: data)
            return .success(object)

        } catch let error as DecodingError {
            return .failure(PrettyDecodingError(error, offendingJSON: data, intendedType: T.self))

        } catch let error as NSError {
            return .failure(error)

        } catch  {
            return .failure(error)
        }
    }
}
