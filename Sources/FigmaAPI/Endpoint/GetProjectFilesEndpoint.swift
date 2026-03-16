import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetProjectFilesEndpoint: BaseEndpoint {
    public typealias Content = [ProjectFile]

    private let projectId: String

    public init(projectId: String) {
        self.projectId = projectId
    }

    func content(from root: ProjectFilesResponse) -> [ProjectFile] {
        root.files
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("projects")
            .appendingPathComponent(projectId)
            .appendingPathComponent("files")
        return URLRequest(url: url)
    }
}

struct ProjectFilesResponse: Decodable {
    let files: [ProjectFile]
}
