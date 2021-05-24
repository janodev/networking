
import Foundation

/// Extra options.
enum Option: String {

    /// Download the results with the appropriate format extension.
    case dl

    /// Download users only, excluding meta information (seed, results, page, and version data).
    case noinfo

    /// Return a payload in JSONP.
    case callback
}
