@testable import FigmaAPI
import XCTest

final class PutWebhookEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let body = PutWebhookBody(eventType: "FILE_DELETE")
        let endpoint = PutWebhookEndpoint(webhookId: "wh1", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v2/webhooks/wh1"
        )
    }

    func testMakeRequestUsesPUTMethod() throws {
        let body = PutWebhookBody(endpoint: "https://example.com/new")
        let endpoint = PutWebhookEndpoint(webhookId: "wh1", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "PUT")
    }

    func testMakeRequestSetsContentTypeHeader() throws {
        let body = PutWebhookBody(passcode: "newpass")
        let endpoint = PutWebhookEndpoint(webhookId: "wh1", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testMakeRequestIncludesBody() throws {
        let body = PutWebhookBody(eventType: "FILE_DELETE", description: "Updated webhook")
        let endpoint = PutWebhookEndpoint(webhookId: "wh1", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let httpBody = try XCTUnwrap(request.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: httpBody) as? [String: Any])
        XCTAssertEqual(json["event_type"] as? String, "FILE_DELETE")
        XCTAssertEqual(json["description"] as? String, "Updated webhook")
    }
}
