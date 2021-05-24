import Networking
import XCTest

extension XCTestCase {
    func parseFull8601<T>(filename: String) throws -> T where T : Decodable {
        let jsonData = try File(filename: filename).data()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
        return try decoder.decode(T.self, from: jsonData)
    }
}
