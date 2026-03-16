import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetFileComponentSetsEndpoint: BaseEndpoint {
    public typealias Content = [ComponentSet]

    private let fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }

    func content(from root: FileComponentSetsResponse) -> [ComponentSet] {
        root.meta.componentSets
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("component_sets")
        return URLRequest(url: url)
    }
}

struct FileComponentSetsResponse: Decodable {
    let meta: FileComponentSetsMeta
}

struct FileComponentSetsMeta: Decodable {
    let componentSets: [ComponentSet]

    private enum CodingKeys: String, CodingKey {
        case componentSets = "component_sets"
    }
}
