@testable import FigmaAPI
import XCTest

final class GetWebhookEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetWebhookEndpoint(webhookId: "wh1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v2/webhooks/wh1"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("WebhookResponse")

        let endpoint = GetWebhookEndpoint(webhookId: "wh1")
        let webhook = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(webhook.id, "wh1")
        XCTAssertEqual(webhook.teamId, "team123")
        XCTAssertEqual(webhook.eventType, "FILE_UPDATE")
        XCTAssertNil(webhook.clientId)
        XCTAssertEqual(webhook.endpoint, "https://example.com/webhook")
        XCTAssertEqual(webhook.passcode, "secret123")
        XCTAssertEqual(webhook.status, "ACTIVE")
        XCTAssertEqual(webhook.description, "File update webhook")
        XCTAssertEqual(webhook.protocolVersion, "2")
    }
}
