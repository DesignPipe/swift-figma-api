import CustomDump
@testable import FigmaAPI
import XCTest

final class GetComponentUsagesEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetComponentUsagesEndpoint(fileKey: "file123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/analytics/libraries/file123/component/usages"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesLibraryUsagesResponse() throws {
        let response: LibraryUsagesResponse = try FixtureLoader.load("LibraryUsagesResponse")

        let endpoint = GetComponentUsagesEndpoint(fileKey: "test")
        let usages = endpoint.content(from: response)

        XCTAssertEqual(usages.count, 1)

        let usage = usages[0]
        XCTAssertEqual(usage.componentKey, "comp1")
        XCTAssertEqual(usage.componentName, "Button")
        XCTAssertNil(usage.styleKey)
        XCTAssertNil(usage.variableKey)
        XCTAssertEqual(usage.usageCount, 150)
    }

    func testContentFromResponseWithBody() throws {
        let data = try FixtureLoader.loadData("LibraryUsagesResponse")

        let endpoint = GetComponentUsagesEndpoint(fileKey: "test")
        let usages = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(usages.count, 1)
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let endpoint = GetComponentUsagesEndpoint(fileKey: "test")

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
