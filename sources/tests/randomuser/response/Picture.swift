import Foundation

public struct Picture: Codable
{
    public let large: URL
    public let medium: URL
    public let thumbnail: URL
}
