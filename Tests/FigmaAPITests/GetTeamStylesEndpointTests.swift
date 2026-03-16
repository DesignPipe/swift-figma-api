@testable import FigmaAPI
import XCTest

final class GetTeamStylesEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetTeamStylesEndpoint(teamId: "team123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/teams/team123/styles"
        )
    }

    func testMakeRequestWithPagination() throws {
        let pagination = PaginationParams(pageSize: 50, cursor: "cursor_token")
        let endpoint = GetTeamStylesEndpoint(teamId: "team123", pagination: pagination)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)
        let url = request.url?.absoluteString ?? ""

        XCTAssertTrue(url.contains("teams/team123/styles"))
        XCTAssertTrue(url.contains("page_size=50"))
        XCTAssertTrue(url.contains("cursor=cursor_token"))
    }

    func testMakeRequestWithoutPaginationHasNoQueryItems() throws {
        let endpoint = GetTeamStylesEndpoint(teamId: "team123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertNil(request.url?.query)
    }

    // MARK: - Response Parsing

    func testContentParsesStylesResponse() throws {
        let response: StylesResponse = try FixtureLoader.load("StylesResponse")

        let endpoint = GetTeamStylesEndpoint(teamId: "team123")
        let styles = endpoint.content(from: response)

        XCTAssertEqual(styles.count, 5)
        XCTAssertEqual(styles[0].name, "primary/background")
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("StylesResponse")

        let endpoint = GetTeamStylesEndpoint(teamId: "team123")
        let styles = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(styles.count, 5)
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetTeamStylesEndpoint(teamId: "team123")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
