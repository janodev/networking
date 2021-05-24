import Foundation

public struct Response: Codable
{
    public let info: Info
    public let users: [User]
    
    enum CodingKeys: String, CodingKey {
        case info
        case users = "results"
    }
}
