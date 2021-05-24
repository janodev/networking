import Foundation

enum URLQueryItemFactory
{    
    static func queryItems(parameters p: Parameters) -> [URLQueryItem] {
        let pagination = p.results.flatMap { $0.urlQueryItems } ?? []
        let options = queryItems(names: p.options)
        let items = [
            queryItem("exc", p.exclude),
            queryItem("format", p.format),
            queryItem("gender", p.gender),
            queryItem("inc", p.include),
            queryItem("nat", p.nationalities),
            queryItem("seed", p.seed),
        ].compactMap { $0 }
        + options
        + pagination
        return items.sorted(by: { $0.name < $1.name })
    }
    
    private static func queryItems<T: RawRepresentable>(names: Set<T>?) -> [URLQueryItem] {
        names?.map { URLQueryItem(name: $0.rawString, value: nil) } ?? []
    }
    
    private static func queryItem(_ name: String, _ string: String?) -> URLQueryItem? {
        string.flatMap { URLQueryItem(name: name, value: $0) }
    }
    
    private static func queryItem<T: RawRepresentable>(_ name: String, _ values: [T]?) -> URLQueryItem? {
        values.flatMap {
            guard $0.count > 0 else { return nil }
            return URLQueryItem(name: name, value: $0.csv())
        }
    }

    private static func queryItem<T: RawRepresentable>(_ name: String, _ value: T?) -> URLQueryItem? {
        value.flatMap { queryItem(name, $0.rawString) }
    }
}

private extension RawRepresentable {
    var rawString: String { "\(self.rawValue)" }
}

private extension Array where Element: RawRepresentable {
    func csv() -> String {
        self.map { $0.rawString }.joined(separator: ",")
    }
}
