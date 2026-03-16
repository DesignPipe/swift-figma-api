import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetActivityLogsEndpoint: BaseEndpoint {
    public typealias Content = [ActivityLog]

    public init() {}

    func content(from root: ActivityLogsResponse) -> [ActivityLog] {
        root.activityLogs
    }

    public func makeRequest(baseURL: URL) -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("activity_logs")
        return URLRequest(url: url)
    }
}

struct ActivityLogsResponse: Decodable {
    let activityLogs: [ActivityLog]

    private enum CodingKeys: String, CodingKey {
        case activityLogs = "activity_logs"
    }
}
