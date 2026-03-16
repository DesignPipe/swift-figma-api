@testable import FigmaAPI
import XCTest

final class GetTeamWebhooksEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetTeamWebhooksEndpoint(teamId: "team123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v2/teams/team123/webhooks"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let response: WebhooksResponse = try FixtureLoader.load("WebhooksResponse")

        let endpoint = GetTeamWebhooksEndpoint(teamId: "team123")
        let webhooks = endpoint.content(from: response)

        XCTAssertEqual(webhooks.count, 2)
        XCTAssertEqual(webhooks[0].id, "wh1")
        XCTAssertEqual(webhooks[1].id, "wh2")
    }
}
