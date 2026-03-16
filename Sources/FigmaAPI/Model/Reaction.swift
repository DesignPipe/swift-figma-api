public struct Reaction: Decodable, Sendable {
    public let emoji: String
    public let user: User
    public let createdAt: String

    private enum CodingKeys: String, CodingKey {
        case emoji, user
        case createdAt = "created_at"
    }
}
