public struct Project: Decodable, Sendable {
    public let id: String
    public let name: String
}

public struct ProjectFile: Decodable, Sendable {
    public let key: String
    public let name: String
    public let thumbnailUrl: String?
    public let lastModified: String

    private enum CodingKeys: String, CodingKey {
        case key, name
        case thumbnailUrl = "thumbnail_url"
        case lastModified = "last_modified"
    }
}
