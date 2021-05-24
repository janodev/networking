import Foundation

public class Resource<T>
{
    public var additionalHeaders: [String: String]
    public var path: String
    public var method: Method
    public var queryItems: [URLQueryItem]
    public var body: Data?
    public var parse: (HTTPResult) -> Result<T, RequestError<T>>

    public func additionalHeaders(_ value: [String: String]) -> Resource<T> {
        additionalHeaders = value
        return self
    }
    public func path(_ value: String) -> Resource<T> {
        path = value
        return self
    }
    public func method(_ value: Method) -> Resource<T> {
        method = value
        return self
    }
    public func addQueryItems(_ value: [URLQueryItem]) -> Resource<T> {
        queryItems += value
        return self
    }
    public func body(_ value: Data?) -> Resource<T> {
        body = value
        return self
    }

    public init(path: String = "",
                body: Data? = nil,
                additionalHeaders: [String: String] = [:],
                method: Method = .GET,
                queryItems: [URLQueryItem] = [],
                parse: @escaping (HTTPResult) -> Result<T, RequestError<T>>)
    {
        self.path = path
        self.body = body
        self.additionalHeaders = additionalHeaders
        self.method = method
        self.queryItems = queryItems
        self.parse = parse
    }

    public static func jsonResource<T: Decodable>() -> Resource<T> {
        Resource<T>(additionalHeaders: MediaType.json.accept) { httpResult in
            return GenericJSONDecoder().parse(result: httpResult)
        }
    }

    public static func textPlainResource() -> Resource<String?> {
        Resource<String?>(additionalHeaders: MediaType.text.accept) { httpResult in
            guard let data = httpResult.data else { return .success(nil) }
            return .success(String(data: data, encoding: .utf8))
        }
    }
}
