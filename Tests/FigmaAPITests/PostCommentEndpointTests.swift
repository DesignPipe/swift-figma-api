@testable import FigmaAPI
import XCTest

final class PostCommentEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let body = PostCommentBody(message: "Hello")
        let endpoint = PostCommentEndpoint(fileId: "abc123", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/comments"
        )
    }

    func testMakeRequestUsesPOSTMethod() throws {
        let body = PostCommentBody(message: "Hello")
        let endpoint = PostCommentEndpoint(fileId: "test", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "POST")
    }

    func testMakeRequestSetsContentTypeHeader() throws {
        let body = PostCommentBody(message: "Hello")
        let endpoint = PostCommentEndpoint(fileId: "test", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testMakeRequestIncludesBody() throws {
        let body = PostCommentBody(message: "Test comment", commentId: "parent1")
        let endpoint = PostCommentEndpoint(fileId: "test", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let httpBody = try XCTUnwrap(request.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: httpBody) as? [String: Any])
        XCTAssertEqual(json["message"] as? String, "Test comment")
        XCTAssertEqual(json["comment_id"] as? String, "parent1")
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("PostCommentResponse")

        let body = PostCommentBody(message: "New comment")
        let endpoint = PostCommentEndpoint(fileId: "test", body: body)
        let comment = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(comment.id, "comment3")
        XCTAssertEqual(comment.message, "New comment")
        XCTAssertEqual(comment.clientMeta?.nodeId, "5:1")
    }
}
