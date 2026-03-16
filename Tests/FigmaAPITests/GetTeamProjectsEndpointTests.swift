@testable import FigmaAPI
import XCTest

final class GetTeamProjectsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetTeamProjectsEndpoint(teamId: "team123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/teams/team123/projects"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesTeamProjectsResponse() throws {
        let response: TeamProjectsResponse = try FixtureLoader.load("TeamProjectsResponse")

        let endpoint = GetTeamProjectsEndpoint(teamId: "team123")
        let projects = endpoint.content(from: response)

        XCTAssertEqual(projects.count, 2)
        XCTAssertEqual(projects[0].id, "proj1")
        XCTAssertEqual(projects[0].name, "Design System")
        XCTAssertEqual(projects[1].id, "proj2")
        XCTAssertEqual(projects[1].name, "Marketing")
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("TeamProjectsResponse")

        let endpoint = GetTeamProjectsEndpoint(teamId: "team123")
        let projects = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(projects.count, 2)
        XCTAssertEqual(projects[0].id, "proj1")
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetTeamProjectsEndpoint(teamId: "team123")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
