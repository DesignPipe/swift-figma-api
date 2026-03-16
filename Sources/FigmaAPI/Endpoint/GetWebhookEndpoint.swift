import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetWebhookEndpoint: BaseEndpoint {
    public typealias Content = Webhook

    private let webhookId: String

    public init(webhookId: String) {
        self.webhookId = webhookId
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v2")
            .appendingPathComponent("webhooks")
            .appendingPathComponent(webhookId)
        return URLRequest(url: url)
    }
}
