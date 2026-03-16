import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetReactionsEndpoint: BaseEndpoint {
    public typealias Content = [Reaction]

    private let fileId: String
    private let commentId: String

    public init(fileId: String, commentId: String) {
        self.fileId = fileId
        self.commentId = commentId
    }

    func content(from root: ReactionsResponse) -> [Reaction] {
        root.reactions
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("comments")
            .appendingPathComponent(commentId)
            .appendingPathComponent("reactions")
        return URLRequest(url: url)
    }
}

struct ReactionsResponse: Decodable {
    let reactions: [Reaction]
}
