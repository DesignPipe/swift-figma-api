import CustomDump
@testable import FigmaAPI
import XCTest

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

final class GetFileMetaEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let endpoint = GetFileMetaEndpoint(fileId: "abc123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123"
        )
    }

    func testMakeRequestUsesHEADMethod() throws {
        let endpoint = GetFileMetaEndpoint(fileId: "abc123")
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "HEAD")
    }

    // MARK: - Response Parsing

    #if !canImport(FoundationNetworking)
    func testContentExtractsHeaderValues() throws {
        let endpoint = GetFileMetaEndpoint(fileId: "abc123")
        let url = try XCTUnwrap(URL(string: "https://api.figma.com/v1/files/abc123"))
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: [
                "Last-Modified": "Wed, 15 Jan 2024 10:30:00 GMT",
                "X-Figma-Version": "123456789",
            ]
        )

        let meta = try endpoint.content(from: response, with: Data())

        XCTAssertEqual(meta.lastModified, "Wed, 15 Jan 2024 10:30:00 GMT")
        XCTAssertEqual(meta.version, "123456789")
    }

    func testContentThrowsOnNonHTTPResponse() {
        let endpoint = GetFileMetaEndpoint(fileId: "abc123")
        let response = URLResponse()

        XCTAssertThrowsError(try endpoint.content(from: response, with: Data()))
    }
    #endif
}
