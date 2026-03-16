@testable import FigmaAPI
import XCTest

final class GetComponentEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetComponentEndpoint(key: "comp_key_123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/components/comp_key_123"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesGetComponentResponse() throws {
        let response: GetComponentResponse = try FixtureLoader.load("GetComponentResponse")

        let endpoint = GetComponentEndpoint(key: "comp_key_123")
        let component = endpoint.content(from: response)

        XCTAssertEqual(component.key, "comp_key_123")
        XCTAssertEqual(component.nodeId, "10:1")
        XCTAssertEqual(component.name, "Button/Primary")
        XCTAssertEqual(component.description, "Primary action button")
        XCTAssertEqual(component.containingFrame.name, "Buttons")
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("GetComponentResponse")

        let endpoint = GetComponentEndpoint(key: "test")
        let component = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(component.key, "comp_key_123")
        XCTAssertEqual(component.name, "Button/Primary")
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetComponentEndpoint(key: "test")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
