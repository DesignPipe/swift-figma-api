public struct PostWebhookBody: Encodable, Sendable {
    public let eventType: String
    public let teamId: String
    public let endpoint: String
    public let passcode: String
    public let description: String?

    public init(eventType: String, teamId: String, endpoint: String, passcode: String, description: String? = nil) {
        self.eventType = eventType
        self.teamId = teamId
        self.endpoint = endpoint
        self.passcode = passcode
        self.description = description
    }

    private enum CodingKeys: String, CodingKey {
        case eventType = "event_type"
        case teamId = "team_id"
        case endpoint, passcode, description
    }
}
