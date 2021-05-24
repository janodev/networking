import Foundation

struct Login: Codable {
    let md5, password, salt, sha1: String
    let sha256, username, uuid: String
}
