import Foundation
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
}
