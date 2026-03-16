public struct User: Decodable, Sendable {
    public let id: String
    public let handle: String
    public let email: String?
    public let imgUrl: String?

    private enum CodingKeys: String, CodingKey {
        case id, handle, email
        case imgUrl = "img_url"
    }
}
