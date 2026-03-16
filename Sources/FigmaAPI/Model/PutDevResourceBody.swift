public struct PutDevResourceBody: Encodable, Sendable {
    public let id: String
    public let name: String?
    public let url: String?
    public let devStatus: String?

    public init(id: String, name: String? = nil, url: String? = nil, devStatus: String? = nil) {
        self.id = id
        self.name = name
        self.url = url
        self.devStatus = devStatus
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, url
        case devStatus = "dev_status"
    }
}
