import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetPaymentsEndpoint: BaseEndpoint {
    public typealias Content = PaymentInfo

    public init() {}

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("payments")
        return URLRequest(url: url)
    }
}
