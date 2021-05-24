import Foundation
import Networking
import Session

final class RandomUserApi: Client
{
    enum BaseURL {
        static let current = URL(string: "https://randomuser.me/api/")!
        static let v13 = URL(string: "https://randomuser.me/api/1.3/")!
    }
    
    init(session: Session) {
        super.init(baseURL: BaseURL.current, session: session)
    }

    func randomuser(parameters: Parameters, completion: @escaping (Swift.Result<Response, RequestError<Response>>) -> Void) {
        let queryItems = URLQueryItemFactory.queryItems(parameters: parameters)
        request(resource: .jsonResource().addQueryItems(queryItems),
                complete: completion)
    }
    
    func page(page: Int, pageSize: Int, completion: @escaping (Swift.Result<Response, RequestError<Response>>) -> Void) {
        let parameters = Parameters(results: .pagination(Pagination(page: page, resultsPerPage: pageSize)))
        let queryItems = URLQueryItemFactory.queryItems(parameters: parameters)
        request(resource: .jsonResource().addQueryItems(queryItems),
                complete: completion)
    }
    
    func results(numberOfResults: Int, completion: @escaping (Swift.Result<Response, RequestError<Response>>) -> Void) {
        let parameters = Parameters(results: .numberOfResults(numberOfResults))
        let queryItems = URLQueryItemFactory.queryItems(parameters: parameters)
        request(resource: .jsonResource().addQueryItems(queryItems),
                complete: completion)
    }
}
