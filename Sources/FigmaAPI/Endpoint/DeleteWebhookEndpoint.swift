import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct DeleteWebhookEndpoint: BaseEndpoint {
    public typealias Content = EmptyResponse

    private let webhookId: String

    public init(webhookId: String) {
        self.webhookId = webhookId
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v2")
            .appendingPathComponent("webhooks")
            .appendingPathComponent(webhookId)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return request
    }
}
