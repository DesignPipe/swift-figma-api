public struct FileVersion: Decodable, Sendable {
    public let id: String
    public let createdAt: String
    public let label: String?
    public let description: String?
    public let user: User

    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case label, description, user
    }
}
