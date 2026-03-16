import CustomDump
@testable import FigmaAPI
import XCTest

final class GetPaymentsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetPaymentsEndpoint()
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/payments"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesPaymentsResponse() throws {
        let data = try FixtureLoader.loadData("PaymentsResponse")

        let endpoint = GetPaymentsEndpoint()
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
        let endpoint = GetPaymentsEndpoint()

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
