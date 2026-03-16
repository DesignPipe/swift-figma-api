@testable import FigmaAPI
import XCTest

final class GetTeamComponentSetsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetTeamComponentSetsEndpoint(teamId: "team123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/teams/team123/component_sets"
        )
    }

    func testMakeRequestWithPagination() throws {
        let pagination = PaginationParams(pageSize: 25, cursor: "next_page")
        let endpoint = GetTeamComponentSetsEndpoint(teamId: "team123", pagination: pagination)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)
        let url = request.url?.absoluteString ?? ""

        XCTAssertTrue(url.contains("teams/team123/component_sets"))
        XCTAssertTrue(url.contains("page_size=25"))
        XCTAssertTrue(url.contains("cursor=next_page"))
    }

    func testMakeRequestWithoutPaginationHasNoQueryItems() throws {
        let endpoint = GetTeamComponentSetsEndpoint(teamId: "team123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertNil(request.url?.query)
    }

    // MARK: - Response Parsing

    func testContentParsesFileComponentSetsResponse() throws {
        let response: FileComponentSetsResponse = try FixtureLoader.load("FileComponentSetsResponse")

        let endpoint = GetTeamComponentSetsEndpoint(teamId: "team123")
        let componentSets = endpoint.content(from: response)

        XCTAssertEqual(componentSets.count, 1)
        XCTAssertEqual(componentSets[0].key, "cs1")
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("FileComponentSetsResponse")

        let endpoint = GetTeamComponentSetsEndpoint(teamId: "team123")
        let componentSets = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(componentSets.count, 1)
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetTeamComponentSetsEndpoint(teamId: "team123")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
