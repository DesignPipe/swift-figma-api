import Foundation
import YYJSON

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct PostCommentEndpoint: BaseEndpoint {
    public typealias Content = Comment

    private let fileId: String
    private let body: PostCommentBody

    public init(fileId: String, body: PostCommentBody) {
        self.fileId = fileId
        self.body = body
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("comments")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try YYJSONEncoder().encode(body)

        return request
    }
}
