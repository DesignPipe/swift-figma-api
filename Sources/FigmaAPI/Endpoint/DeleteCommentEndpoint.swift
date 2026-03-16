import Foundation
import YYJSON
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct DeleteCommentEndpoint: BaseEndpoint {
    public typealias Content = EmptyResponse

    private let fileId: String
    private let commentId: String

    public init(fileId: String, commentId: String) {
        self.fileId = fileId
        self.commentId = commentId
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("comments")
            .appendingPathComponent(commentId)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return request
    }

    public func content(from _: URLResponse?, with body: Data) throws -> EmptyResponse {
        if body.isEmpty { return EmptyResponse() }
        return try YYJSONDecoder().decode(EmptyResponse.self, from: body)
    }
}
