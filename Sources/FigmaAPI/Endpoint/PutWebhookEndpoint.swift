import Foundation
import YYJSON

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct PutWebhookEndpoint: BaseEndpoint {
    public typealias Content = Webhook

    private let webhookId: String
    private let body: PutWebhookBody

    public init(webhookId: String, body: PutWebhookBody) {
        self.webhookId = webhookId
        self.body = body
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v2")
            .appendingPathComponent("webhooks")
            .appendingPathComponent(webhookId)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try YYJSONEncoder().encode(body)
        return request
    }
}
