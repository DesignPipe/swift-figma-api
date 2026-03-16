public struct Comment: Decodable, Sendable {
    public let id: String
    public let message: String
    public let createdAt: String
    public let resolvedAt: String?
    public let user: User
    public let orderId: String?
    public let parentId: String?
    public let clientMeta: ClientMeta?

    private enum CodingKeys: String, CodingKey {
        case id, message, user
        case createdAt = "created_at"
        case resolvedAt = "resolved_at"
        case orderId = "order_id"
        case parentId = "parent_id"
        case clientMeta = "client_meta"
    }
}

public struct ClientMeta: Decodable, Sendable {
    public let nodeId: String?
    public let nodeOffset: Vector?

    private enum CodingKeys: String, CodingKey {
        case nodeId = "node_id"
        case nodeOffset = "node_offset"
    }
}
