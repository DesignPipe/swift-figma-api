@testable import FigmaAPI
import XCTest

final class DeleteCommentEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = DeleteCommentEndpoint(fileId: "abc123", commentId: "comment1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/comments/comment1"
        )
    }

    func testMakeRequestUsesDELETEMethod() throws {
        let endpoint = DeleteCommentEndpoint(fileId: "abc123", commentId: "comment1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "DELETE")
    }

    // MARK: - Response Parsing

    func testContentParsesEmptyResponse() throws {
        let data = Data("{}".utf8)
        let endpoint = DeleteCommentEndpoint(fileId: "test", commentId: "c1")
        let response = try endpoint.content(from: nil, with: data)

        // EmptyResponse just needs to decode without error
        XCTAssertNotNil(response)
    }
}
