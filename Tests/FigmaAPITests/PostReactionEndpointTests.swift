@testable import FigmaAPI
import XCTest

final class PostReactionEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let body = PostReactionBody(emoji: "👍")
        let endpoint = PostReactionEndpoint(fileId: "abc123", commentId: "comment1", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/comments/comment1/reactions"
        )
    }

    func testMakeRequestUsesPOSTMethod() throws {
        let body = PostReactionBody(emoji: "👍")
        let endpoint = PostReactionEndpoint(fileId: "test", commentId: "c1", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "POST")
    }

    func testMakeRequestSetsContentTypeHeader() throws {
        let body = PostReactionBody(emoji: "👍")
        let endpoint = PostReactionEndpoint(fileId: "test", commentId: "c1", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testMakeRequestIncludesBody() throws {
        let body = PostReactionBody(emoji: "🎉")
        let endpoint = PostReactionEndpoint(fileId: "test", commentId: "c1", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let httpBody = try XCTUnwrap(request.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: httpBody) as? [String: Any])
        XCTAssertEqual(json["emoji"] as? String, "\u{1F389}")
    }

    // MARK: - Response Parsing

    func testContentParsesEmptyResponse() throws {
        let data = Data("{}".utf8)
        let body = PostReactionBody(emoji: "👍")
        let endpoint = PostReactionEndpoint(fileId: "test", commentId: "c1", body: body)
        let response = try endpoint.content(from: nil, with: data)

        XCTAssertNotNil(response)
    }
}
