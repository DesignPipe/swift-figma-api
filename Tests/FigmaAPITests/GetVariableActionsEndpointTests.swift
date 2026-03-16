import CustomDump
@testable import FigmaAPI
import XCTest

final class GetVariableActionsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetVariableActionsEndpoint(fileKey: "file123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/analytics/libraries/file123/variable/actions"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesLibraryActionsResponse() throws {
        let response: LibraryActionsResponse = try FixtureLoader.load("LibraryActionsResponse")

        let endpoint = GetVariableActionsEndpoint(fileKey: "test")
        let actions = endpoint.content(from: response)

        XCTAssertEqual(actions.count, 1)
        XCTAssertEqual(actions[0].actionType, "INSERT")
        XCTAssertEqual(actions[0].actionCount, 42)
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("LibraryActionsResponse")

        let endpoint = GetVariableActionsEndpoint(fileKey: "test")
        let actions = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(actions.count, 1)
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetVariableActionsEndpoint(fileKey: "test")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
