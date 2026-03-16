@testable import FigmaAPI
import XCTest

final class GetWebhooksEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetWebhooksEndpoint()
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v2/webhooks"
        )
    }

    func testMakeRequestWithContextFilter() throws {
        let endpoint = GetWebhooksEndpoint(context: "team", contextId: "team123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let components = try XCTUnwrap(URLComponents(url: try XCTUnwrap(request.url), resolvingAgainstBaseURL: false))
        XCTAssertEqual(components.path, "/v2/webhooks")
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == "context" })?.value, "team")
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == "context_id" })?.value, "team123")
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

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("WebhooksResponse")

        let endpoint = GetWebhooksEndpoint()
        let webhooks = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(webhooks.count, 2)
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetWebhooksEndpoint()

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
