@testable import FigmaAPI
import XCTest

final class GetCommentsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetCommentsEndpoint(fileId: "abc123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/comments"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let response: CommentsResponse = try FixtureLoader.load("CommentsResponse")

        let endpoint = GetCommentsEndpoint(fileId: "test")
        let comments = endpoint.content(from: response)

        XCTAssertEqual(comments.count, 2)
    }

    func testContentParsesCommentWithClientMeta() throws {
        let response: CommentsResponse = try FixtureLoader.load("CommentsResponse")

        let endpoint = GetCommentsEndpoint(fileId: "test")
        let comments = endpoint.content(from: response)

        let first = comments[0]
        XCTAssertEqual(first.id, "comment1")
        XCTAssertEqual(first.message, "Great design!")
        XCTAssertEqual(first.clientMeta?.nodeId, "10:1")
        XCTAssertEqual(first.clientMeta?.nodeOffset?.x, 100.0)
        XCTAssertEqual(first.clientMeta?.nodeOffset?.y, 200.0)
    }

    func testContentParsesResolvedComment() throws {
        let response: CommentsResponse = try FixtureLoader.load("CommentsResponse")

        let endpoint = GetCommentsEndpoint(fileId: "test")
        let comments = endpoint.content(from: response)

        let second = comments[1]
        XCTAssertEqual(second.id, "comment2")
        XCTAssertEqual(second.resolvedAt, "2024-01-16T09:00:00Z")
        XCTAssertEqual(second.parentId, "comment1")
    }
}
