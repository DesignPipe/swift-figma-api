public struct PutDevResourceBody: Encodable, Sendable {
    public let id: String
    public let name: String?
    public let url: String?

    public init(id: String, name: String? = nil, url: String? = nil) {
        self.id = id
        self.name = name
        self.url = url
    }
}
