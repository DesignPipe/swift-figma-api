import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetPaymentsEndpoint: BaseEndpoint {
    public typealias Content = PaymentInfo

    private let pluginPaymentToken: String?
    private let userId: String?
    private let pluginId: String?
    private let widgetId: String?
    private let communityFileId: String?

    public init(
        pluginPaymentToken: String? = nil,
        userId: String? = nil,
        pluginId: String? = nil,
        widgetId: String? = nil,
        communityFileId: String? = nil
    ) {
        self.pluginPaymentToken = pluginPaymentToken
        self.userId = userId
        self.pluginId = pluginId
        self.widgetId = widgetId
        self.communityFileId = communityFileId
    }

    func content(from root: PaymentsResponse) -> PaymentInfo {
        root.meta
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("payments")
        guard var comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        var items: [URLQueryItem] = []
        if let pluginPaymentToken { items.append(URLQueryItem(name: "plugin_payment_token", value: pluginPaymentToken)) }
        if let userId { items.append(URLQueryItem(name: "user_id", value: userId)) }
        if let pluginId { items.append(URLQueryItem(name: "plugin_id", value: pluginId)) }
        if let widgetId { items.append(URLQueryItem(name: "widget_id", value: widgetId)) }
        if let communityFileId { items.append(URLQueryItem(name: "community_file_id", value: communityFileId)) }
        if !items.isEmpty { comps.queryItems = items }
        guard let finalURL = comps.url else {
            throw URLError(.badURL)
        }
        return URLRequest(url: finalURL)
    }
}

struct PaymentsResponse: Decodable {
    let meta: PaymentInfo
}
