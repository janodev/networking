import Foundation

/// Page of results to get.
struct Pagination {
    
    let page: Int
    let resultsPerPage: Int
    
    var urlQueryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "page", value: page.description),
            URLQueryItem(name: "results", value: resultsPerPage.description)
        ]
    }
}
