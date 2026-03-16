import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetTeamComponentSetsEndpoint: BaseEndpoint {
    public typealias Content = [ComponentSet]

    private let teamId: String
    private let pagination: PaginationParams?

    public init(teamId: String, pagination: PaginationParams? = nil) {
        self.teamId = teamId
        self.pagination = pagination
    }

    func content(from root: FileComponentSetsResponse) -> [ComponentSet] {
        root.meta.componentSets
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("teams")
            .appendingPathComponent(teamId)
            .appendingPathComponent("component_sets")
        guard var comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        let items = pagination?.queryItems ?? []
        if !items.isEmpty { comps.queryItems = items }
        guard let finalURL = comps.url else {
            throw URLError(.badURL)
        }
        return URLRequest(url: finalURL)
    }
}
