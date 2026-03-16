public struct PutWebhookBody: Encodable, Sendable {
    public let eventType: String?
    public let endpoint: String?
    public let passcode: String?
    public let description: String?

    public init(eventType: String? = nil, endpoint: String? = nil, passcode: String? = nil, description: String? = nil) {
        self.eventType = eventType
        self.endpoint = endpoint
        self.passcode = passcode
        self.description = description
    }

    private enum CodingKeys: String, CodingKey {
        case eventType = "event_type"
        case endpoint, passcode, description
    }
}
