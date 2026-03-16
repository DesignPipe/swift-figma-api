import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetComponentUsagesEndpoint: BaseEndpoint {
    public typealias Content = [LibraryAnalyticsUsage]

    private let fileKey: String

    public init(fileKey: String) {
        self.fileKey = fileKey
    }

    func content(from root: LibraryUsagesResponse) -> [LibraryAnalyticsUsage] {
        root.usages
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("analytics")
            .appendingPathComponent("libraries")
            .appendingPathComponent(fileKey)
            .appendingPathComponent("component")
            .appendingPathComponent("usages")
        return URLRequest(url: url)
    }
}

struct LibraryUsagesResponse: Decodable {
    let usages: [LibraryAnalyticsUsage]
}
