import os

enum Signpost
{
    private static let subsystem = "dev.jano.network"
    private static let category = "request"
    private static let name: StaticString = "network"
    private static let log = OSLog(subsystem: subsystem, category: category)
    private static let id = OSSignpostID(log: log)

    static func begin(message: StaticString, _ arguments: CVarArg...) {
        os_signpost(.begin, log: log, name: name, signpostID: id, message, arguments)
    }
    static func end(message: StaticString, _ arguments: CVarArg...) {
        os_signpost(.end, log: log, name: name, signpostID: id, message, arguments)
    }
}
