import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetFileVersionsEndpoint: BaseEndpoint {
    public typealias Content = [FileVersion]

    private let fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }

    func content(from root: FileVersionsResponse) -> [FileVersion] {
        root.versions
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("versions")
        return URLRequest(url: url)
    }
}

struct FileVersionsResponse: Decodable {
    let versions: [FileVersion]
}
