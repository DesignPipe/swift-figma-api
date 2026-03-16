import Foundation
import YYJSON

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct PostReactionEndpoint: BaseEndpoint {
    public typealias Content = EmptyResponse

    private let fileId: String
    private let commentId: String
    private let body: PostReactionBody

    public init(fileId: String, commentId: String, body: PostReactionBody) {
        self.fileId = fileId
        self.commentId = commentId
        self.body = body
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("comments")
            .appendingPathComponent(commentId)
            .appendingPathComponent("reactions")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try YYJSONEncoder().encode(body)

        return request
    }
}
