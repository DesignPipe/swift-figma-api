public struct WebhookRequest: Decodable, Sendable {
    public let id: String
    public let endpoint: String
    public let payload: WebhookPayload?
    public let error: String?
    public let createdAt: String

    private enum CodingKeys: String, CodingKey {
        case id, endpoint, payload, error
        case createdAt = "created_at"
    }
}

public struct WebhookPayload: Decodable, Sendable {
    public let eventType: String?
    public let timestamp: String?

    private enum CodingKeys: String, CodingKey {
        case eventType = "event_type"
        case timestamp
    }
}
