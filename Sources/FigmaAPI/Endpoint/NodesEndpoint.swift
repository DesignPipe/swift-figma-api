import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Option for requesting geometry data from the Nodes endpoint.
public enum GeometryOption: String, Sendable {
    /// Include path geometry (`fillGeometry`, `strokeGeometry`) in the response.
    case paths
}

public struct NodesEndpoint: BaseEndpoint {
    public typealias Content = [NodeId: Node]

    private let nodeIds: String
    private let fileId: String
    private let geometry: GeometryOption?

    public init(fileId: String, nodeIds: [String], geometry: GeometryOption? = nil) {
        self.fileId = fileId
        self.nodeIds = nodeIds.joined(separator: ",")
        self.geometry = geometry
    }

    func content(from root: NodesResponse) -> Content {
        root.nodes
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("files")
            .appendingPathComponent(fileId)
            .appendingPathComponent("nodes")

        var comps = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var queryItems = [
            URLQueryItem(name: "ids", value: nodeIds),
        ]
        if let geometry {
            queryItems.append(URLQueryItem(name: "geometry", value: geometry.rawValue))
        }
        comps?.queryItems = queryItems
        guard let components = comps, let url = components.url else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL components for NodesEndpoint"])
        }
        return URLRequest(url: url)
    }
}
