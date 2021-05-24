import Foundation

struct Timezone: Codable {
    let timezoneDescription, offset: String

    enum CodingKeys: String, CodingKey {
        case timezoneDescription = "description"
        case offset
    }
}
