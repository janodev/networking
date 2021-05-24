import Foundation
import Networking

public struct Location: Codable {
    
    public let city: String
    public let coordinates: Coordinates
    public let country: String
    public let postcode: String
    public let state: String
    public let street: Street
    public let timezone: Timezone
    
    enum CodingKeys: String, CodingKey {
        case city
        case coordinates
        case country
        case postcode
        case state
        case street
        case timezone
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        self.country = try container.decode(String.self, forKey: .country)
        
        let postcodeMeta = try container.decode(MetadataType.self, forKey: .postcode)
        switch postcodeMeta {
        case .double(let value): self.postcode = String(value)
        case .int(let value): self.postcode = String(value)
        case .string(let value): self.postcode = String(value)
        }
        
        self.state = try container.decode(String.self, forKey: .state)
        self.street = try container.decode(Street.self, forKey: .street)
        self.timezone = try container.decode(Timezone.self, forKey: .timezone)
    }
}
