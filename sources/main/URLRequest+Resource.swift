import Foundation

public extension URLRequest
{
    init?<T>(resource: Resource<T>, baseURL: URL)
    {
        guard let url = URLRequest.createURL(for: resource, relativeTo: baseURL) else {
            return nil
        }
        self.init(url: url)
        httpMethod = resource.method.rawValue
        httpBody = resource.body
        allHTTPHeaderFields = resource.additionalHeaders
    }

    private static func createURL<T>(for resource: Resource<T>, relativeTo baseURL: URL) -> URL?
    {
        let url = baseURL.appendingPathComponent(resource.path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        if !resource.queryItems.isEmpty {
            components.queryItems = resource.queryItems
        }
        return components.url
    }
}
