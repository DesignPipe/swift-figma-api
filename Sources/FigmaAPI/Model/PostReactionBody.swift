public struct PostReactionBody: Encodable, Sendable {
    public let emoji: String

    public init(emoji: String) {
        self.emoji = emoji
    }
}
