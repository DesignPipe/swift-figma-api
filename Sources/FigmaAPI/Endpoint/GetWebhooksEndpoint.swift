import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetWebhooksEndpoint: BaseEndpoint {
    public typealias Content = [Webhook]

    private let context: String?
    private let contextId: String?

    public init(context: String? = nil, contextId: String? = nil) {
        self.context = context
        self.contextId = contextId
    }

    func content(from root: WebhooksResponse) -> [Webhook] {
        root.webhooks
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v2")
            .appendingPathComponent("webhooks")
        guard var comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        var items: [URLQueryItem] = []
        if let context { items.append(URLQueryItem(name: "context", value: context)) }
        if let contextId { items.append(URLQueryItem(name: "context_id", value: contextId)) }
        if !items.isEmpty { comps.queryItems = items }
        guard let finalURL = comps.url else {
            throw URLError(.badURL)
        }
        return URLRequest(url: finalURL)
    }
}

struct WebhooksResponse: Decodable {
    let webhooks: [Webhook]
}
