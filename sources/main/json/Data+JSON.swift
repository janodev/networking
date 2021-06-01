import Foundation

public extension Data
{
    func toJSON() -> Any? {
        try? JSONSerialization.jsonObject(with: self, options: [])
    }
    func toJSONString() -> String? {
        guard
            let jsonObject = toJSON(),
            JSONSerialization.isValidJSONObject(jsonObject),
            let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.sortedKeys, .prettyPrinted])
        else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
