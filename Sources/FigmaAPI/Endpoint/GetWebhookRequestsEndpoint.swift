import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetWebhookRequestsEndpoint: BaseEndpoint {
    public typealias Content = [WebhookRequest]

    private let webhookId: String

    public init(webhookId: String) {
        self.webhookId = webhookId
    }

    func content(from root: WebhookRequestsResponse) -> [WebhookRequest] {
        root.requests
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v2")
            .appendingPathComponent("webhooks")
            .appendingPathComponent(webhookId)
            .appendingPathComponent("requests")
        return URLRequest(url: url)
    }
}

struct WebhookRequestsResponse: Decodable {
    let requests: [WebhookRequest]
}
