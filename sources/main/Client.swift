import Foundation
import os
import Session

open class Client
{
    private let baseURL: URL
    private var session: Session
    public var timeout = TimeInterval(20)

    public init(baseURL: URL, session: Session) {
        self.baseURL = baseURL
        self.session = session
    }

    /// Runs a network request.
    ///
    /// - Parameters:
    ///   - resource: Resource used to create a Request.
    ///   - complete: Returns the result. 
    public func request<T>(resource: Resource<T>, complete: @escaping (Result<T, RequestError<T>>) -> Void) {

        guard let request = URLRequest(resource: resource, baseURL: baseURL) else {
            return complete(.failure(.invalidEndpoint(resource, baseURL)))
        }

        let _complete: (Result<T, RequestError<T>>) -> Void = { result in

            Signpost.end(message: "%@ %@", resource.method.rawValue, resource.path)
            complete(result)
        }
        Signpost.begin(message: "%@ %@", resource.method.rawValue, resource.path)

        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            // return on error
            if let error = error {
                _complete(.failure(.error(error)))
                return
            }

            // return on other response than HTTP
            guard let httpURLResponse = response as? HTTPURLResponse else {
                _complete(.failure(.expectedHTTPResponse(response)))
                return
            }

            log.trace("\(Report(request: request, response: httpURLResponse, error: error, data: data))")

            // return on HTTP error status code
            guard let status = Status(code: httpURLResponse.statusCode), !status.isError else {
                _complete(.failure(.httpStatusError(httpURLResponse.statusCode)))
                return
            }

            let httpResult = HTTPResult(data: data, response: httpURLResponse)
            let result = resource.parse(httpResult)
            _complete(result)
        })
        task.resume()
    }

    public func requestSync<T>(_ resource: Resource<T>) -> Result<T, RequestError<T>>
    {
        let semaphore = DispatchSemaphore(value: 0)
        var response: Result<T, RequestError<T>>?
        request(resource: resource) { (result: Result<T, RequestError>) in
            response = result
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + timeout)
        return response ?? Result.failure(RequestError.timeout(timeout))
    }
}
