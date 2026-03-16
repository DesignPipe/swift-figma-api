import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct DeleteDevResourceEndpoint: BaseEndpoint {
    public typealias Content = EmptyResponse

    private let fileId: String
    private let resourceId: String

    public init(fileId: String, resourceId: String) {
        self.fileId = fileId
        self.resourceId = resourceId
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("dev_resources")
            .appendingPathComponent(resourceId)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return request
    }
}
