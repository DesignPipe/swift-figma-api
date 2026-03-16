import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetWebhooksEndpoint: BaseEndpoint {
    public typealias Content = [Webhook]

    public init() {}

    func content(from root: WebhooksResponse) -> [Webhook] {
        root.webhooks
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v2")
            .appendingPathComponent("webhooks")
        return URLRequest(url: url)
    }
}

struct WebhooksResponse: Decodable {
    let webhooks: [Webhook]
}
