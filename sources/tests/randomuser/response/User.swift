import Foundation

public struct User: Codable
{
    public let cell: String?
    public let dob: YearsAgo?
    public let email: String?
    public let gender: String?
    public let id: ID?
    public let location: Location?
    public let login: Login?
    public let name: Name?
    public let nat: String?
    public let phone: String?
    public let picture: Picture?
    public let registered: YearsAgo?
}
