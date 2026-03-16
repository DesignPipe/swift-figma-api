public struct ComponentSet: Decodable, Sendable {
    public let key: String
    public let nodeId: String
    public let name: String
    public let description: String?
    public let containingFrame: ContainingFrame

    private enum CodingKeys: String, CodingKey {
        case key
        case nodeId = "node_id"
        case name, description
        case containingFrame = "containing_frame"
    }
}
