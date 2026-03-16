import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetComponentSetEndpoint: BaseEndpoint {
    public typealias Content = ComponentSet

    private let key: String

    public init(key: String) {
        self.key = key
    }

    func content(from root: GetComponentSetResponse) -> ComponentSet {
        root.meta
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("component_sets")
            .appendingPathComponent(key)
        return URLRequest(url: url)
    }
}

struct GetComponentSetResponse: Decodable {
    let meta: ComponentSet
}
