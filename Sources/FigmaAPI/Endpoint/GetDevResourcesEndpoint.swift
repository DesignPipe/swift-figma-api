import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetDevResourcesEndpoint: BaseEndpoint {
    public typealias Content = [DevResource]

    private let fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }

    func content(from root: DevResourcesResponse) -> [DevResource] {
        root.devResources
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("dev_resources")
        return URLRequest(url: url)
    }
}

struct DevResourcesResponse: Decodable {
    let devResources: [DevResource]

    private enum CodingKeys: String, CodingKey {
        case devResources = "dev_resources"
    }
}
