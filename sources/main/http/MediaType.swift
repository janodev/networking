struct MediaType
{
    let type: String

    var accept: [String: String] {
        ["Accept": type]
    }
    var contentType: [String: String] {
        ["Content-Type": type]
    }

    static let json = MediaType(type: "application/json")

    static let css = MediaType(type: "text/css")
    static let text = MediaType(type: "text/plain")
    static let html = MediaType(type: "text/html")

    static let gif = MediaType(type: "image/gif")
    static let jpeg = MediaType(type: "image/jpeg")
    static let png = MediaType(type: "image/png")
    static let svg = MediaType(type: "image/svg")
    static let webp = MediaType(type: "image/webp")
}
