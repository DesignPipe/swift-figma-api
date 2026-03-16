import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetStyleEndpoint: BaseEndpoint {
    public typealias Content = Style

    private let key: String

    public init(key: String) {
        self.key = key
    }

    func content(from root: GetStyleResponse) -> Style {
        root.meta
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("styles")
            .appendingPathComponent(key)
        return URLRequest(url: url)
    }
}

struct GetStyleResponse: Decodable {
    let meta: Style
}
