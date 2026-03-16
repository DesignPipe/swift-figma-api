import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetStyleActionsEndpoint: BaseEndpoint {
    public typealias Content = [LibraryAnalyticsAction]

    private let fileKey: String

    public init(fileKey: String) {
        self.fileKey = fileKey
    }

    func content(from root: LibraryActionsResponse) -> [LibraryAnalyticsAction] {
        root.actions
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("analytics")
            .appendingPathComponent("libraries")
            .appendingPathComponent(fileKey)
            .appendingPathComponent("style")
            .appendingPathComponent("actions")
        return URLRequest(url: url)
    }
}
