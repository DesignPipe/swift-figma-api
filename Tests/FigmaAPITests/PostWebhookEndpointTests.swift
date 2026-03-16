@testable import FigmaAPI
import XCTest

final class PostWebhookEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let body = PostWebhookBody(eventType: "FILE_UPDATE", teamId: "team123", endpoint: "https://example.com/webhook", passcode: "secret")
        let endpoint = PostWebhookEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v2/webhooks"
        )
    }

    func testMakeRequestUsesPOSTMethod() throws {
        let body = PostWebhookBody(eventType: "FILE_UPDATE", teamId: "team123", endpoint: "https://example.com/webhook", passcode: "secret")
        let endpoint = PostWebhookEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "POST")
    }

    func testMakeRequestSetsContentTypeHeader() throws {
        let body = PostWebhookBody(eventType: "FILE_UPDATE", teamId: "team123", endpoint: "https://example.com/webhook", passcode: "secret")
        let endpoint = PostWebhookEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testMakeRequestIncludesBody() throws {
        let body = PostWebhookBody(eventType: "FILE_UPDATE", teamId: "team123", endpoint: "https://example.com/webhook", passcode: "secret", description: "My webhook")
        let endpoint = PostWebhookEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let httpBody = try XCTUnwrap(request.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: httpBody) as? [String: Any])
        XCTAssertEqual(json["event_type"] as? String, "FILE_UPDATE")
        XCTAssertEqual(json["team_id"] as? String, "team123")
        XCTAssertEqual(json["endpoint"] as? String, "https://example.com/webhook")
        XCTAssertEqual(json["passcode"] as? String, "secret")
        XCTAssertEqual(json["description"] as? String, "My webhook")
    }
}
