public struct Webhook: Codable, Sendable {
    public let id: String
    public let teamId: String
    public let eventType: String
    public let clientId: String?
    public let endpoint: String
    public let passcode: String?
    public let status: String
    public let description: String?
    public let protocolVersion: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case teamId = "team_id"
        case eventType = "event_type"
        case clientId = "client_id"
        case endpoint, passcode, status, description
        case protocolVersion = "protocol_version"
    }
}
