public struct ActivityLog: Decodable, Sendable {
    public let id: String
    public let timestamp: String
    public let actorId: String?
    public let actionType: String
    public let entityType: String
    public let details: [String: String]?

    private enum CodingKeys: String, CodingKey {
        case id, timestamp
        case actorId = "actor_id"
        case actionType = "action_type"
        case entityType = "entity_type"
        case details
    }
}
