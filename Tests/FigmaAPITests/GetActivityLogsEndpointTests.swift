import CustomDump
@testable import FigmaAPI
import XCTest

final class GetActivityLogsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetActivityLogsEndpoint()
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/activity_logs"
        )
    }

    func testMakeRequestWithFilters() throws {
        let endpoint = GetActivityLogsEndpoint(
            events: "FILE_OPEN,FILE_DELETE",
            startTime: 1704067200.0,
            endTime: 1706745599.0,
            limit: 50,
            order: "desc"
        )
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let components = try XCTUnwrap(URLComponents(url: try XCTUnwrap(request.url), resolvingAgainstBaseURL: false))
        let queryItems = try XCTUnwrap(components.queryItems)
        XCTAssertEqual(queryItems.first(where: { $0.name == "events" })?.value, "FILE_OPEN,FILE_DELETE")
        XCTAssertNotNil(queryItems.first(where: { $0.name == "start_time" }))
        XCTAssertNotNil(queryItems.first(where: { $0.name == "end_time" }))
        XCTAssertEqual(queryItems.first(where: { $0.name == "limit" })?.value, "50")
        XCTAssertEqual(queryItems.first(where: { $0.name == "order" })?.value, "desc")
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
