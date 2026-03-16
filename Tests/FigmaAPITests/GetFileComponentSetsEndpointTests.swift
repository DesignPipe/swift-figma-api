@testable import FigmaAPI
import XCTest

final class GetFileComponentSetsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetFileComponentSetsEndpoint(fileId: "abc123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/component_sets"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesFileComponentSetsResponse() throws {
        let response: FileComponentSetsResponse = try FixtureLoader.load("FileComponentSetsResponse")

        let endpoint = GetFileComponentSetsEndpoint(fileId: "test")
        let componentSets = endpoint.content(from: response)

        XCTAssertEqual(componentSets.count, 1)
        XCTAssertEqual(componentSets[0].key, "cs1")
        XCTAssertEqual(componentSets[0].name, "Button")
        XCTAssertEqual(componentSets[0].description, "Buttons")
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("FileComponentSetsResponse")

        let endpoint = GetFileComponentSetsEndpoint(fileId: "test")
        let componentSets = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(componentSets.count, 1)
        XCTAssertEqual(componentSets[0].key, "cs1")
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetFileComponentSetsEndpoint(fileId: "test")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
