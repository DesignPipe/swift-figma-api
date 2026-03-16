import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetImageFillsEndpoint: BaseEndpoint {
    public typealias Content = [String: String]

    private let fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }

    func content(from root: ImageFillsResponse) -> [String: String] {
        root.meta.images
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("images")
        return URLRequest(url: url)
    }
}

struct ImageFillsResponse: Decodable {
    let meta: ImageFillsMeta
}

struct ImageFillsMeta: Decodable {
    let images: [String: String]
}
