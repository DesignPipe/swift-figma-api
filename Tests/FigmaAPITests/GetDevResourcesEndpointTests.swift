@testable import FigmaAPI
import XCTest

final class GetDevResourcesEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetDevResourcesEndpoint(fileId: "abc123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/dev_resources"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let response: DevResourcesResponse = try FixtureLoader.load("DevResourcesResponse")

        let endpoint = GetDevResourcesEndpoint(fileId: "test")
        let resources = endpoint.content(from: response)

        XCTAssertEqual(resources.count, 2)
    }

    func testContentParsesFirstResource() throws {
        let response: DevResourcesResponse = try FixtureLoader.load("DevResourcesResponse")

        let endpoint = GetDevResourcesEndpoint(fileId: "test")
        let resources = endpoint.content(from: response)

        let first = resources[0]
        XCTAssertEqual(first.id, "res1")
        XCTAssertEqual(first.name, "Storybook")
        XCTAssertEqual(first.url, "https://storybook.example.com/button")
        XCTAssertEqual(first.nodeId, "10:1")
        XCTAssertEqual(first.devStatus, "ready_for_dev")
    }

    func testContentParsesResourceWithNullDevStatus() throws {
        let response: DevResourcesResponse = try FixtureLoader.load("DevResourcesResponse")

        let endpoint = GetDevResourcesEndpoint(fileId: "test")
        let resources = endpoint.content(from: response)

        let second = resources[1]
        XCTAssertEqual(second.id, "res2")
        XCTAssertNil(second.devStatus)
    }
}
