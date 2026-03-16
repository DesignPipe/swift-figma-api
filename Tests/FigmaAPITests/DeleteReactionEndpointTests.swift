@testable import FigmaAPI
import XCTest

final class DeleteReactionEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = DeleteReactionEndpoint(fileId: "abc123", commentId: "comment1", emoji: "👍")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertTrue(
            request.url?.absoluteString.starts(with:
                "https://api.figma.com/v1/files/abc123/comments/comment1/reactions") ?? false
        )
    }

    func testMakeRequestIncludesEmojiQueryParameter() throws {
        let endpoint = DeleteReactionEndpoint(fileId: "abc123", commentId: "comment1", emoji: "👍")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let components = try XCTUnwrap(URLComponents(url: try XCTUnwrap(request.url), resolvingAgainstBaseURL: false))
        let emojiItem = components.queryItems?.first(where: { $0.name == "emoji" })
        XCTAssertEqual(emojiItem?.value, "\u{1F44D}")
    }

    func testMakeRequestUsesDELETEMethod() throws {
        let endpoint = DeleteReactionEndpoint(fileId: "abc123", commentId: "comment1", emoji: "👍")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "DELETE")
    }

    // MARK: - Response Parsing

    func testContentParsesEmptyBody() throws {
        let data = Data()
        let endpoint = DeleteReactionEndpoint(fileId: "test", commentId: "c1", emoji: "👍")
        let response = try endpoint.content(from: nil, with: data)

        XCTAssertNotNil(response)
    }

    func testContentParsesEmptyJSONBody() throws {
        let data = Data("{}".utf8)
        let endpoint = DeleteReactionEndpoint(fileId: "test", commentId: "c1", emoji: "👍")
        let response = try endpoint.content(from: nil, with: data)

        XCTAssertNotNil(response)
    }
}
