import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetFileMetaEndpoint: Endpoint {
    public typealias Content = FileMeta

    private let fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        return request
    }

    public func content(from response: URLResponse?, with body: Data) throws -> FileMeta {
        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        return FileMeta(
            lastModified: http.value(forHTTPHeaderField: "Last-Modified"),
            version: http.value(forHTTPHeaderField: "X-Figma-Version")
        )
    }
}
