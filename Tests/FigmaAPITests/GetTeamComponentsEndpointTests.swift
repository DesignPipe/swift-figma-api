@testable import FigmaAPI
import XCTest

final class GetTeamComponentsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetTeamComponentsEndpoint(teamId: "team123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/teams/team123/components"
        )
    }

    func testMakeRequestWithPagination() throws {
        let pagination = PaginationParams(pageSize: 10, cursor: "abc")
        let endpoint = GetTeamComponentsEndpoint(teamId: "team123", pagination: pagination)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)
        let url = request.url?.absoluteString ?? ""

        XCTAssertTrue(url.contains("teams/team123/components"))
        XCTAssertTrue(url.contains("page_size=10"))
        XCTAssertTrue(url.contains("cursor=abc"))
    }

    func testMakeRequestWithoutPaginationHasNoQueryItems() throws {
        let endpoint = GetTeamComponentsEndpoint(teamId: "team123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertNil(request.url?.query)
    }

    // MARK: - Response Parsing

    func testContentParsesComponentsResponse() throws {
        let response: ComponentsResponse = try FixtureLoader.load("ComponentsResponse")

        let endpoint = GetTeamComponentsEndpoint(teamId: "team123")
        let components = endpoint.content(from: response)

        XCTAssertEqual(components.count, 4)
        XCTAssertEqual(components[0].name, "Icons/24/arrow_right")
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("ComponentsResponse")

        let endpoint = GetTeamComponentsEndpoint(teamId: "team123")
        let components = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(components.count, 4)
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetTeamComponentsEndpoint(teamId: "team123")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
