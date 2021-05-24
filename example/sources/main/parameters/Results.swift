import Foundation

/// Number of results to get.
enum Results {
    
    /// Return a number of results.
    case numberOfResults(Int)
    
    /// Return an specific page of results.
    case pagination(Pagination)
    
    var urlQueryItems: [URLQueryItem] {
        switch self {
        case .numberOfResults(let number):
            return [URLQueryItem(name: "results", value: number.description)]
        case .pagination(let pagination):
            return pagination.urlQueryItems
        }
    }
}
