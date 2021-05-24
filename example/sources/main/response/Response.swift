import Foundation

struct Response: Codable {
    let info: Info
    let results: [Result]
}
