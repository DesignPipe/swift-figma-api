import Foundation

public struct PostCommentBody: Encodable, Sendable {
    public let message: String
    public let clientMeta: PostClientMeta?
    public let commentId: String?

    public init(message: String, clientMeta: PostClientMeta? = nil, commentId: String? = nil) {
        self.message = message
        self.clientMeta = clientMeta
        self.commentId = commentId
    }

    private enum CodingKeys: String, CodingKey {
        case message
        case clientMeta = "client_meta"
        case commentId = "comment_id"
    }
}

public struct PostClientMeta: Encodable, Sendable {
    public let nodeId: String?
    public let nodeOffset: PostVector?

    public init(nodeId: String? = nil, nodeOffset: PostVector? = nil) {
        self.nodeId = nodeId
        self.nodeOffset = nodeOffset
    }

    private enum CodingKeys: String, CodingKey {
        case nodeId = "node_id"
        case nodeOffset = "node_offset"
    }
}

public struct PostVector: Encodable, Sendable {
    public let x: Double
    public let y: Double

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}
