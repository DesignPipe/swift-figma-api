import Foundation
import YYJSON

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct PostWebhookEndpoint: BaseEndpoint {
    public typealias Content = Webhook

    private let body: PostWebhookBody

    public init(body: PostWebhookBody) {
        self.body = body
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v2")
            .appendingPathComponent("webhooks")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try YYJSONEncoder().encode(body)
        return request
    }
}
