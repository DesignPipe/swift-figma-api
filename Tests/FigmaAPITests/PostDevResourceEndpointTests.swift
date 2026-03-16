@testable import FigmaAPI
import XCTest

final class PostDevResourceEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let body = PostDevResourceBody(name: "Test", url: "https://example.com", fileKey: "abc123", nodeId: "10:1")
        let endpoint = PostDevResourceEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/dev_resources"
        )
    }

    func testMakeRequestUsesPOSTMethod() throws {
        let body = PostDevResourceBody(name: "Test", url: "https://example.com", fileKey: "abc123", nodeId: "10:1")
        let endpoint = PostDevResourceEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "POST")
    }

    func testMakeRequestSetsContentTypeHeader() throws {
        let body = PostDevResourceBody(name: "Test", url: "https://example.com", fileKey: "abc123", nodeId: "10:1")
        let endpoint = PostDevResourceEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testMakeRequestWrapsBodyInDevResourcesArray() throws {
        let body = PostDevResourceBody(name: "Storybook", url: "https://storybook.example.com", fileKey: "file1", nodeId: "10:1", devStatus: "ready_for_dev")
        let endpoint = PostDevResourceEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let httpBody = try XCTUnwrap(request.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: httpBody) as? [String: Any])
        let devResources = try XCTUnwrap(json["dev_resources"] as? [[String: Any]])
        XCTAssertEqual(devResources.count, 1)
        XCTAssertEqual(devResources[0]["name"] as? String, "Storybook")
        XCTAssertEqual(devResources[0]["url"] as? String, "https://storybook.example.com")
        XCTAssertEqual(devResources[0]["file_key"] as? String, "file1")
        XCTAssertEqual(devResources[0]["node_id"] as? String, "10:1")
        XCTAssertEqual(devResources[0]["dev_status"] as? String, "ready_for_dev")
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("PostDevResourceResponse")

        let body = PostDevResourceBody(name: "New Resource", url: "https://example.com/resource", fileKey: "file1", nodeId: "15:1")
        let endpoint = PostDevResourceEndpoint(body: body)
        let resources = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(resources.count, 1)
        XCTAssertEqual(resources[0].id, "res3")
        XCTAssertEqual(resources[0].name, "New Resource")
        XCTAssertEqual(resources[0].nodeId, "15:1")
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let body = PostDevResourceBody(name: "Test", url: "https://example.com", fileKey: "file1", nodeId: "10:1")
        let endpoint = PostDevResourceEndpoint(body: body)

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
