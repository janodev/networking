import Foundation

extension GenericJSONDecoder
{
    func parse<T: Decodable>(result: HTTPResult) -> Result<T, RequestError<T>>
    {
        guard let data = result.data else {
            return .failure(.expectedNonEmptyContent)
        }
        return map(from: decode(data))
    }

    private func map<T: Decodable>(from: Result<T, Error>) -> Result<T, RequestError<T>> {
        switch from {
        case let .success(obj):
            return .success(obj)
        case let .failure(err):
            return .failure(RequestError.error(err))
        }
    }
}
