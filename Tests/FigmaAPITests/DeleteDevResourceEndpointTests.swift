@testable import FigmaAPI
import XCTest

final class DeleteDevResourceEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = DeleteDevResourceEndpoint(fileId: "abc123", resourceId: "res1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/dev_resources/res1"
        )
    }

    func testMakeRequestUsesDELETEMethod() throws {
        let endpoint = DeleteDevResourceEndpoint(fileId: "abc123", resourceId: "res1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "DELETE")
    }

    // MARK: - Response Parsing

    func testContentParsesEmptyBody() throws {
        let data = Data()
        let endpoint = DeleteDevResourceEndpoint(fileId: "test", resourceId: "res1")
        let response = try endpoint.content(from: nil, with: data)

        XCTAssertNotNil(response)
    }

    func testContentParsesEmptyJSONBody() throws {
        let data = Data("{}".utf8)
        let endpoint = DeleteDevResourceEndpoint(fileId: "test", resourceId: "res1")
        let response = try endpoint.content(from: nil, with: data)

        XCTAssertNotNil(response)
    }
}
