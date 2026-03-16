@testable import FigmaAPI
import XCTest

final class GetWebhooksEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetWebhooksEndpoint()
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v2/webhooks"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let response: WebhooksResponse = try FixtureLoader.load("WebhooksResponse")

        let endpoint = GetWebhooksEndpoint()
        let webhooks = endpoint.content(from: response)

        XCTAssertEqual(webhooks.count, 2)
    }

    func testContentParsesFirstWebhook() throws {
        let response: WebhooksResponse = try FixtureLoader.load("WebhooksResponse")

        let endpoint = GetWebhooksEndpoint()
        let webhooks = endpoint.content(from: response)

        let first = webhooks[0]
        XCTAssertEqual(first.id, "wh1")
        XCTAssertEqual(first.teamId, "team123")
        XCTAssertEqual(first.eventType, "FILE_UPDATE")
        XCTAssertNil(first.clientId)
        XCTAssertEqual(first.status, "ACTIVE")
    }

    func testContentParsesSecondWebhook() throws {
        let response: WebhooksResponse = try FixtureLoader.load("WebhooksResponse")

        let endpoint = GetWebhooksEndpoint()
        let webhooks = endpoint.content(from: response)

        let second = webhooks[1]
        XCTAssertEqual(second.id, "wh2")
        XCTAssertEqual(second.eventType, "FILE_DELETE")
        XCTAssertEqual(second.clientId, "client456")
        XCTAssertNil(second.passcode)
        XCTAssertEqual(second.status, "PAUSED")
        XCTAssertNil(second.description)
    }
}
