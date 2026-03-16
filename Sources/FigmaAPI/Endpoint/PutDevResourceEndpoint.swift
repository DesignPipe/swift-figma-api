import Foundation
import YYJSON

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct PutDevResourceEndpoint: BaseEndpoint {
    public typealias Content = [DevResource]

    private let body: PutDevResourceBody

    public init(body: PutDevResourceBody) {
        self.body = body
    }

    func content(from root: LinksUpdatedResponse) -> [DevResource] {
        root.linksUpdated
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("dev_resources")

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try YYJSONEncoder().encode(PutDevResourcesWrapper(devResources: [body]))

        return request
    }
}

struct PutDevResourcesWrapper: Encodable {
    let devResources: [PutDevResourceBody]

    private enum CodingKeys: String, CodingKey {
        case devResources = "dev_resources"
    }
}

struct LinksUpdatedResponse: Decodable {
    let linksUpdated: [DevResource]

    private enum CodingKeys: String, CodingKey {
        case linksUpdated = "links_updated"
    }
}
