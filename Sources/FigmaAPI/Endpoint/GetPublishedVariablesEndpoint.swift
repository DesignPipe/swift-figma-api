import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetPublishedVariablesEndpoint: BaseEndpoint {
    public typealias Content = VariablesMeta

    private let fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }

    func content(from root: VariablesResponse) -> VariablesMeta {
        root.meta
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("variables")
            .appendingPathComponent("published")
        return URLRequest(url: url)
    }
}
