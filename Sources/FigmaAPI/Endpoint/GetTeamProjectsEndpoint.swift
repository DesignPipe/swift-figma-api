import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetTeamProjectsEndpoint: BaseEndpoint {
    public typealias Content = [Project]

    private let teamId: String

    public init(teamId: String) {
        self.teamId = teamId
    }

    func content(from root: TeamProjectsResponse) -> [Project] {
        root.projects
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("teams")
            .appendingPathComponent(teamId)
            .appendingPathComponent("projects")
        return URLRequest(url: url)
    }
}

struct TeamProjectsResponse: Decodable {
    let projects: [Project]
}
