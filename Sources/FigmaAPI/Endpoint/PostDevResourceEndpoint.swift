import Foundation
import YYJSON

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct PostDevResourceEndpoint: BaseEndpoint {
    public typealias Content = [DevResource]

    private let body: PostDevResourceBody

    public init(body: PostDevResourceBody) {
        self.body = body
    }

    func content(from root: LinksCreatedResponse) -> [DevResource] {
        root.linksCreated
    }

    public func makeRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL
            .appendingPathComponent("v1")
            .appendingPathComponent("dev_resources")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try YYJSONEncoder().encode(DevResourcesWrapper(devResources: [body]))

        return request
    }
}

struct DevResourcesWrapper: Encodable {
    let devResources: [PostDevResourceBody]

    private enum CodingKeys: String, CodingKey {
        case devResources = "dev_resources"
    }
}

struct LinksCreatedResponse: Decodable {
    let linksCreated: [DevResource]

    private enum CodingKeys: String, CodingKey {
        case linksCreated = "links_created"
    }
}
