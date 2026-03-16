@testable import FigmaAPI
import XCTest

final class GetStyleEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetStyleEndpoint(key: "style_key_789")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/styles/style_key_789"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesGetStyleResponse() throws {
        let response: GetStyleResponse = try FixtureLoader.load("GetStyleResponse")

        let endpoint = GetStyleEndpoint(key: "test")
        let style = endpoint.content(from: response)

        XCTAssertEqual(style.nodeId, "5:1")
        XCTAssertEqual(style.name, "Colors/Primary")
        XCTAssertEqual(style.styleType, .fill)
        XCTAssertEqual(style.description, "Primary brand color")
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("GetStyleResponse")

        let endpoint = GetStyleEndpoint(key: "test")
        let style = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(style.name, "Colors/Primary")
        XCTAssertEqual(style.styleType, .fill)
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetStyleEndpoint(key: "test")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
