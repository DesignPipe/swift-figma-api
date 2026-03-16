public struct PostDevResourceBody: Encodable, Sendable {
    public let name: String
    public let url: String
    public let fileKey: String
    public let nodeId: String
    public let devStatus: String?

    public init(name: String, url: String, fileKey: String, nodeId: String, devStatus: String? = nil) {
        self.name = name
        self.url = url
        self.fileKey = fileKey
        self.nodeId = nodeId
        self.devStatus = devStatus
    }

    private enum CodingKeys: String, CodingKey {
        case name, url
        case fileKey = "file_key"
        case nodeId = "node_id"
        case devStatus = "dev_status"
    }
}
