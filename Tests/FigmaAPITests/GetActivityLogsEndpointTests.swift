import CustomDump
@testable import FigmaAPI
import XCTest

final class GetActivityLogsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetActivityLogsEndpoint()
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/activity_logs"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesActivityLogsResponse() throws {
        let response: ActivityLogsResponse = try FixtureLoader.load("ActivityLogsResponse")

        let endpoint = GetActivityLogsEndpoint()
        let logs = endpoint.content(from: response)

        XCTAssertEqual(logs.count, 2)

        let firstLog = logs[0]
        XCTAssertEqual(firstLog.id, "log1")
        XCTAssertEqual(firstLog.timestamp, "2024-01-15T10:30:00Z")
        XCTAssertEqual(firstLog.actorId, "user1")
        XCTAssertEqual(firstLog.actionType, "FILE_OPEN")
        XCTAssertEqual(firstLog.entityType, "FILE")
        XCTAssertEqual(firstLog.details?["file_key"], "abc123")

        let secondLog = logs[1]
        XCTAssertNil(secondLog.actorId)
        XCTAssertNil(secondLog.details)
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("ActivityLogsResponse")

        let endpoint = GetActivityLogsEndpoint()
        let logs = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(logs.count, 2)
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetActivityLogsEndpoint()

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
