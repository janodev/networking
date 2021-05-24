import Foundation

public struct Login: Codable
{
    public let md5: String
    public let password: String
    public let salt: String
    public let sha1: String
    public let sha256: String
    public let username: String
    public let uuid: String
}
