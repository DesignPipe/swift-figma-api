import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetCommentsEndpoint: BaseEndpoint {
    public typealias Content = [Comment]

    private let fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }

    func content(from root: CommentsResponse) -> [Comment] {
        root.comments
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("comments")
        return URLRequest(url: url)
    }
}

struct CommentsResponse: Decodable {
    let comments: [Comment]
}
