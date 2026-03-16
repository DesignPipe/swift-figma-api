import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetMeEndpoint: BaseEndpoint {
    public typealias Content = User

    public init() {}

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL.appendingPathComponent("v1").appendingPathComponent("me")
        return URLRequest(url: url)
    }
}
