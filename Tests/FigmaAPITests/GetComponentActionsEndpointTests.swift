import CustomDump
@testable import FigmaAPI
import XCTest

final class GetComponentActionsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetComponentActionsEndpoint(fileKey: "file123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/analytics/libraries/file123/component/actions"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesLibraryActionsResponse() throws {
        let response: LibraryActionsResponse = try FixtureLoader.load("LibraryActionsResponse")

        let endpoint = GetComponentActionsEndpoint(fileKey: "test")
        let actions = endpoint.content(from: response)

        XCTAssertEqual(actions.count, 1)

        let action = actions[0]
        XCTAssertEqual(action.componentKey, "comp1")
        XCTAssertEqual(action.componentName, "Button")
        XCTAssertNil(action.styleKey)
        XCTAssertNil(action.variableKey)
        XCTAssertEqual(action.actionType, "INSERT")
        XCTAssertEqual(action.actionCount, 42)
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("LibraryActionsResponse")

        let endpoint = GetComponentActionsEndpoint(fileKey: "test")
        let actions = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(actions.count, 1)
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetComponentActionsEndpoint(fileKey: "test")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
