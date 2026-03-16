import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

@available(*, deprecated, message: "Use GetWebhooksEndpoint instead")
public struct GetTeamWebhooksEndpoint: BaseEndpoint {
    public typealias Content = [Webhook]

    private let teamId: String

    public init(teamId: String) {
        self.teamId = teamId
    }

    func content(from root: WebhooksResponse) -> [Webhook] {
        root.webhooks
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v2")
            .appendingPathComponent("teams")
            .appendingPathComponent(teamId)
            .appendingPathComponent("webhooks")
        return URLRequest(url: url)
    }
}
