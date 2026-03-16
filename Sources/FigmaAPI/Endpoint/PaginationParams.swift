import Foundation

public struct PaginationParams: Sendable {
    public let pageSize: Int?
    public let cursor: String?

    public init(pageSize: Int? = nil, cursor: String? = nil) {
        self.pageSize = pageSize
        self.cursor = cursor
    }

    public var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        if let pageSize { items.append(.init(name: "page_size", value: "\(pageSize)")) }
        if let cursor { items.append(.init(name: "cursor", value: cursor)) }
        return items
    }
}
