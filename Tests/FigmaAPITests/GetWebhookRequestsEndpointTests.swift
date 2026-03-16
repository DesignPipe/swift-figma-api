@testable import FigmaAPI
import XCTest

final class GetWebhookRequestsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetWebhookRequestsEndpoint(webhookId: "wh1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v2/webhooks/wh1/requests"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let response: WebhookRequestsResponse = try FixtureLoader.load("WebhookRequestsResponse")

        let endpoint = GetWebhookRequestsEndpoint(webhookId: "wh1")
        let requests = endpoint.content(from: response)

        XCTAssertEqual(requests.count, 2)
    }

    func testContentParsesRequestWithPayload() throws {
        let response: WebhookRequestsResponse = try FixtureLoader.load("WebhookRequestsResponse")

        let endpoint = GetWebhookRequestsEndpoint(webhookId: "wh1")
        let requests = endpoint.content(from: response)

        let first = requests[0]
        XCTAssertEqual(first.id, "req1")
        XCTAssertEqual(first.endpoint, "https://example.com/webhook")
        XCTAssertEqual(first.payload?.eventType, "FILE_UPDATE")
        XCTAssertEqual(first.payload?.timestamp, "2024-01-15T10:30:00Z")
        XCTAssertNil(first.error)
        XCTAssertEqual(first.createdAt, "2024-01-15T10:30:01Z")
    }

    func testContentParsesRequestWithError() throws {
        let response: WebhookRequestsResponse = try FixtureLoader.load("WebhookRequestsResponse")

        let endpoint = GetWebhookRequestsEndpoint(webhookId: "wh1")
        let requests = endpoint.content(from: response)

        let second = requests[1]
        XCTAssertEqual(second.id, "req2")
        XCTAssertNil(second.payload)
        XCTAssertEqual(second.error, "Connection timeout")
    }
}
