import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct DeleteReactionEndpoint: BaseEndpoint {
    public typealias Content = EmptyResponse

    private let fileId: String
    private let commentId: String
    private let emoji: String

    public init(fileId: String, commentId: String, emoji: String) {
        self.fileId = fileId
        self.commentId = commentId
        self.emoji = emoji
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("comments")
            .appendingPathComponent(commentId)
            .appendingPathComponent("reactions")
        guard var comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        comps.queryItems = [URLQueryItem(name: "emoji", value: emoji)]
        guard let finalURL = comps.url else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: finalURL)
        request.httpMethod = "DELETE"
        return request
    }
}
