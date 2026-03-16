import CustomDump
@testable import FigmaAPI
import XCTest

final class GetPublishedVariablesEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetPublishedVariablesEndpoint(fileId: "abc123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/variables/published"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("PublishedVariablesResponse")

        let endpoint = GetPublishedVariablesEndpoint(fileId: "test")
        let meta = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(meta.variableCollections.count, 1)
        XCTAssertEqual(meta.variables.count, 1)

        let collection = meta.variableCollections["VariableCollectionId:2:1"]
        XCTAssertEqual(collection?.name, "Published Colors")

        let variable = meta.variables["VariableID:2:2"]
        XCTAssertEqual(variable?.name, "brand/primary")
        XCTAssertEqual(variable?.description, "Primary brand color")
    }
}
