import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetComponentEndpoint: BaseEndpoint {
    public typealias Content = Component

    private let key: String

    public init(key: String) {
        self.key = key
    }

    func content(from root: GetComponentResponse) -> Component {
        root.meta
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("components")
            .appendingPathComponent(key)
        return URLRequest(url: url)
    }
}

struct GetComponentResponse: Decodable {
    let meta: Component
}
