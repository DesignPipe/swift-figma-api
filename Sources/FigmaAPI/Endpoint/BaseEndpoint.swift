import Foundation
import YYJSON

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

/// Base Endpoint for application remote resource.
///
/// Contains shared logic for all endpoints in app.
protocol BaseEndpoint: Endpoint where Content: Decodable {
    /// Content wrapper.
    associatedtype Root: Decodable = Content

    /// Extract content from root.
    func content(from root: Root) -> Content
}

extension BaseEndpoint where Root == Content {
    func content(from root: Root) -> Content {
        root
    }
}

extension BaseEndpoint {
    public func content(from _: URLResponse?, with body: Data) throws -> Content {
        do {
            // Models use explicit CodingKeys for snake_case mapping
            let resource = try YYJSONDecoder().decode(Root.self, from: body)
            return content(from: resource)
        } catch let mainError {
            if let error = try? YYJSONDecoder().decode(FigmaClientError.self, from: body) {
                throw error
            }

            throw mainError
        }
    }
}
