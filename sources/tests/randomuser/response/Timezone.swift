import Foundation

public struct Timezone: Codable
{
    public let timezoneDescription: String
    public let offset: String

    enum CodingKeys: String, CodingKey {
        case timezoneDescription = "description"
        case offset
    }
}
