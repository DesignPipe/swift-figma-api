@testable import FigmaAPI
import XCTest

final class GetComponentSetEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetComponentSetEndpoint(key: "cs_key_456")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/component_sets/cs_key_456"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesGetComponentSetResponse() throws {
        let response: GetComponentSetResponse = try FixtureLoader.load("GetComponentSetResponse")

        let endpoint = GetComponentSetEndpoint(key: "cs_key_456")
        let componentSet = endpoint.content(from: response)

        XCTAssertEqual(componentSet.key, "cs_key_456")
        XCTAssertEqual(componentSet.nodeId, "20:1")
        XCTAssertEqual(componentSet.name, "Button")
        XCTAssertEqual(componentSet.description, "Button component set with variants")
        XCTAssertEqual(componentSet.containingFrame.name, "Buttons")
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("GetComponentSetResponse")

        let endpoint = GetComponentSetEndpoint(key: "test")
        let componentSet = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(componentSet.key, "cs_key_456")
        XCTAssertEqual(componentSet.name, "Button")
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetComponentSetEndpoint(key: "test")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
