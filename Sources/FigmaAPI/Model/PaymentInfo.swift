public struct PaymentInfo: Decodable, Sendable {
    public let status: Int
    public let users: [PaymentUser]?
}

public struct PaymentUser: Decodable, Sendable {
    public let userId: String
    public let status: String

    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case status
    }
}
