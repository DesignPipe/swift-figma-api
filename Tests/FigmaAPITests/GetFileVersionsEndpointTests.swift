import CustomDump
@testable import FigmaAPI
import XCTest

final class GetFileVersionsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetFileVersionsEndpoint(fileId: "abc123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/versions"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("FileVersionsResponse")

        let endpoint = GetFileVersionsEndpoint(fileId: "test")
        let versions = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(versions.count, 2)

        let first = versions[0]
        XCTAssertEqual(first.id, "ver123")
        XCTAssertEqual(first.createdAt, "2024-01-15T10:30:00Z")
        XCTAssertEqual(first.label, "v1.0")
        XCTAssertEqual(first.description, "Initial release")
        XCTAssertEqual(first.user.handle, "Designer")
    }

    func testContentParsesVersionWithNullFields() throws {
        let data = try FixtureLoader.loadData("FileVersionsResponse")

        let endpoint = GetFileVersionsEndpoint(fileId: "test")
        let versions = try endpoint.content(from: nil, with: data)

        let second = versions[1]
        XCTAssertEqual(second.id, "ver456")
        XCTAssertNil(second.label)
        XCTAssertNil(second.description)
        XCTAssertNil(second.user.email)
        XCTAssertNil(second.user.imgUrl)
    }
}
