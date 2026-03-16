import CustomDump
@testable import FigmaAPI
import XCTest

final class GetPaymentsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetPaymentsEndpoint(pluginId: "plugin123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let components = try XCTUnwrap(URLComponents(url: try XCTUnwrap(request.url), resolvingAgainstBaseURL: false))
        XCTAssertEqual(components.path, "/v1/payments")
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == "plugin_id" })?.value, "plugin123")
    }

    func testMakeRequestWithTokenAuth() throws {
        let endpoint = GetPaymentsEndpoint(pluginPaymentToken: "token123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let components = try XCTUnwrap(URLComponents(url: try XCTUnwrap(request.url), resolvingAgainstBaseURL: false))
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == "plugin_payment_token" })?.value, "token123")
    }

    func testMakeRequestWithUserAndWidget() throws {
        let endpoint = GetPaymentsEndpoint(userId: "user1", widgetId: "widget1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let components = try XCTUnwrap(URLComponents(url: try XCTUnwrap(request.url), resolvingAgainstBaseURL: false))
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == "user_id" })?.value, "user1")
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == "widget_id" })?.value, "widget1")
    }

    // MARK: - Response Parsing

    func testContentParsesPaymentsResponse() throws {
        let data = try FixtureLoader.loadData("PaymentsResponse")

        let endpoint = GetPaymentsEndpoint(pluginId: "plugin123")
        let paymentInfo = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(paymentInfo.status, 200)
        XCTAssertEqual(paymentInfo.users?.count, 2)
        XCTAssertEqual(paymentInfo.users?[0].userId, "user1")
        XCTAssertEqual(paymentInfo.users?[0].status, "active")
        XCTAssertEqual(paymentInfo.users?[1].userId, "user2")
        XCTAssertEqual(paymentInfo.users?[1].status, "inactive")
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetPaymentsEndpoint(pluginId: "plugin123")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
