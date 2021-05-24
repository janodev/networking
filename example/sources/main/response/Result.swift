import Foundation

struct Result: Codable {
    let cell: String
    let dob: YearsAgo
    let email, gender: String
    let id: ID
    let location: Location
    let login: Login
    let name: Name
    let nat, phone: String
    let picture: Picture
    let registered: YearsAgo
}
