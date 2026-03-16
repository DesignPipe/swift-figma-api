@testable import FigmaAPI
import XCTest

final class GetReactionsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetReactionsEndpoint(fileId: "abc123", commentId: "comment1")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/comments/comment1/reactions"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let response: ReactionsResponse = try FixtureLoader.load("ReactionsResponse")

        let endpoint = GetReactionsEndpoint(fileId: "test", commentId: "c1")
        let reactions = endpoint.content(from: response)

        XCTAssertEqual(reactions.count, 2)
    }

    func testContentParsesFirstReaction() throws {
        let response: ReactionsResponse = try FixtureLoader.load("ReactionsResponse")

        let endpoint = GetReactionsEndpoint(fileId: "test", commentId: "c1")
        let reactions = endpoint.content(from: response)

        let first = reactions[0]
        XCTAssertEqual(first.emoji, "\u{1F44D}")
        XCTAssertEqual(first.user.id, "user1")
        XCTAssertEqual(first.user.handle, "Designer")
        XCTAssertEqual(first.createdAt, "2024-01-15T10:30:00Z")
    }

    func testContentParsesReactionWithNullUserFields() throws {
        let response: ReactionsResponse = try FixtureLoader.load("ReactionsResponse")

        let endpoint = GetReactionsEndpoint(fileId: "test", commentId: "c1")
        let reactions = endpoint.content(from: response)

        let second = reactions[1]
        XCTAssertEqual(second.emoji, "\u{1F389}")
        XCTAssertNil(second.user.email)
        XCTAssertNil(second.user.imgUrl)
    }
}
