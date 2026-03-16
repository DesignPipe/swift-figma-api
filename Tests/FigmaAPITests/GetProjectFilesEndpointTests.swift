@testable import FigmaAPI
import XCTest

final class GetProjectFilesEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetProjectFilesEndpoint(projectId: "proj123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/projects/proj123/files"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesProjectFilesResponse() throws {
        let response: ProjectFilesResponse = try FixtureLoader.load("ProjectFilesResponse")

        let endpoint = GetProjectFilesEndpoint(projectId: "proj123")
        let files = endpoint.content(from: response)

        XCTAssertEqual(files.count, 2)
        XCTAssertEqual(files[0].key, "file1")
        XCTAssertEqual(files[0].name, "Components")
        XCTAssertEqual(files[0].thumbnailUrl, "https://example.com/thumb1.png")
        XCTAssertEqual(files[0].lastModified, "2024-01-15T10:30:00Z")
        XCTAssertEqual(files[1].key, "file2")
        XCTAssertNil(files[1].thumbnailUrl)
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("ProjectFilesResponse")

        let endpoint = GetProjectFilesEndpoint(projectId: "proj123")
        let files = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(files.count, 2)
        XCTAssertEqual(files[0].key, "file1")
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetProjectFilesEndpoint(projectId: "proj123")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
