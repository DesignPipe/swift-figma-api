import Foundation
import YYJSON

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct PostDevResourceEndpoint: BaseEndpoint {
    public typealias Content = DevResource

    private let fileId: String
    private let body: PostDevResourceBody

    public init(fileId: String, body: PostDevResourceBody) {
        self.fileId = fileId
        self.body = body
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("dev_resources")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try YYJSONEncoder().encode(body)

        return request
    }
}
