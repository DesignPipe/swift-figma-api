import CustomDump
@testable import FigmaAPI
import XCTest

final class GetImageFillsEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetImageFillsEndpoint(fileId: "abc123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/images"
        )
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("ImageFillsResponse")

        let endpoint = GetImageFillsEndpoint(fileId: "test")
        let images = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(images.count, 2)
        XCTAssertEqual(images["0:1"], "https://s3-alpha.figma.com/img/abc/123/image1.png")
        XCTAssertEqual(images["0:2"], "https://s3-alpha.figma.com/img/def/456/image2.png")
    }
}
