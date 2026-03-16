import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct GetActivityLogsEndpoint: BaseEndpoint {
    public typealias Content = [ActivityLog]

    private let events: String?
    private let startTime: Double?
    private let endTime: Double?
    private let limit: Int?
    private let order: String?

    public init(
        events: String? = nil,
        startTime: Double? = nil,
        endTime: Double? = nil,
        limit: Int? = nil,
        order: String? = nil
    ) {
        self.events = events
        self.startTime = startTime
        self.endTime = endTime
        self.limit = limit
        self.order = order
    }

    func content(from root: ActivityLogsResponse) -> [ActivityLog] {
        root.activityLogs
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("activity_logs")
        guard var comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        var items: [URLQueryItem] = []
        if let events { items.append(URLQueryItem(name: "events", value: events)) }
        if let startTime { items.append(URLQueryItem(name: "start_time", value: "\(startTime)")) }
        if let endTime { items.append(URLQueryItem(name: "end_time", value: "\(endTime)")) }
        if let limit { items.append(URLQueryItem(name: "limit", value: "\(limit)")) }
        if let order { items.append(URLQueryItem(name: "order", value: order)) }
        if !items.isEmpty { comps.queryItems = items }
        guard let finalURL = comps.url else {
            throw URLError(.badURL)
        }
        return URLRequest(url: finalURL)
    }
}

struct ActivityLogsResponse: Decodable {
    let activityLogs: [ActivityLog]

    private enum CodingKeys: String, CodingKey {
        case activityLogs = "activity_logs"
    }
}
