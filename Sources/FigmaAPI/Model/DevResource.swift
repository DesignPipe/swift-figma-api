public struct DevResource: Decodable, Sendable {
    public let id: String
    public let name: String
    public let url: String
    public let nodeId: String
    public let devStatus: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, url
        case nodeId = "node_id"
        case devStatus = "dev_status"
    }
}
