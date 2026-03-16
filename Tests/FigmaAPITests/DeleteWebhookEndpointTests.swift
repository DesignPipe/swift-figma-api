@testable import FigmaAPI
import XCTest

final class DeleteWebhookEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = DeleteWebhookEndpoint(webhookId: "wh1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v2/webhooks/wh1"
        )
    }

    func testMakeRequestUsesDELETEMethod() throws {
        let endpoint = DeleteWebhookEndpoint(webhookId: "wh1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "DELETE")
    }

    // MARK: - Response Parsing

    func testContentParsesEmptyResponse() throws {
        let data = Data("{}".utf8)
        let endpoint = DeleteWebhookEndpoint(webhookId: "wh1")
        let response = try endpoint.content(from: nil, with: data)

        XCTAssertNotNil(response)
    }
}
