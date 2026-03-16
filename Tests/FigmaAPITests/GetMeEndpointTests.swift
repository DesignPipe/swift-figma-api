import CustomDump
@testable import FigmaAPI
import XCTest

final class GetMeEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetMeEndpoint()
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/me"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("GetMeResponse")

        let endpoint = GetMeEndpoint()
        let user = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(user.id, "user123")
        XCTAssertEqual(user.handle, "John Doe")
        XCTAssertEqual(user.email, "john@example.com")
        XCTAssertEqual(user.imgUrl, "https://example.com/avatar.png")
    }
}
