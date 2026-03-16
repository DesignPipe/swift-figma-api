@testable import FigmaAPI
import XCTest

final class PostDevResourceEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let body = PostDevResourceBody(name: "Test", url: "https://example.com", nodeId: "10:1")
        let endpoint = PostDevResourceEndpoint(fileId: "abc123", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/dev_resources"
        )
    }

    func testMakeRequestUsesPOSTMethod() throws {
        let body = PostDevResourceBody(name: "Test", url: "https://example.com", nodeId: "10:1")
        let endpoint = PostDevResourceEndpoint(fileId: "test", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "POST")
    }

    func testMakeRequestSetsContentTypeHeader() throws {
        let body = PostDevResourceBody(name: "Test", url: "https://example.com", nodeId: "10:1")
        let endpoint = PostDevResourceEndpoint(fileId: "test", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testMakeRequestIncludesBody() throws {
        let body = PostDevResourceBody(name: "Storybook", url: "https://storybook.example.com", nodeId: "10:1", devStatus: "ready_for_dev")
        let endpoint = PostDevResourceEndpoint(fileId: "test", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let httpBody = try XCTUnwrap(request.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: httpBody) as? [String: Any])
        XCTAssertEqual(json["name"] as? String, "Storybook")
        XCTAssertEqual(json["url"] as? String, "https://storybook.example.com")
        XCTAssertEqual(json["node_id"] as? String, "10:1")
        XCTAssertEqual(json["dev_status"] as? String, "ready_for_dev")
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("PostDevResourceResponse")

        let body = PostDevResourceBody(name: "New Resource", url: "https://example.com/resource", nodeId: "15:1")
        let endpoint = PostDevResourceEndpoint(fileId: "test", body: body)
        let resource = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(resource.id, "res3")
        XCTAssertEqual(resource.name, "New Resource")
        XCTAssertEqual(resource.nodeId, "15:1")
    }
}
