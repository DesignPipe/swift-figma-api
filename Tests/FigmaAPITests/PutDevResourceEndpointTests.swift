@testable import FigmaAPI
import XCTest

final class PutDevResourceEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let body = PutDevResourceBody(id: "res1", name: "Updated")
        let endpoint = PutDevResourceEndpoint(fileId: "abc123", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/files/abc123/dev_resources"
        )
    }

    func testMakeRequestUsesPUTMethod() throws {
        let body = PutDevResourceBody(id: "res1", name: "Updated")
        let endpoint = PutDevResourceEndpoint(fileId: "test", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "PUT")
    }

    func testMakeRequestSetsContentTypeHeader() throws {
        let body = PutDevResourceBody(id: "res1", name: "Updated")
        let endpoint = PutDevResourceEndpoint(fileId: "test", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testMakeRequestIncludesBody() throws {
        let body = PutDevResourceBody(id: "res1", name: "Updated Name", url: "https://new.example.com", devStatus: "completed")
        let endpoint = PutDevResourceEndpoint(fileId: "test", body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let httpBody = try XCTUnwrap(request.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: httpBody) as? [String: Any])
        XCTAssertEqual(json["id"] as? String, "res1")
        XCTAssertEqual(json["name"] as? String, "Updated Name")
        XCTAssertEqual(json["url"] as? String, "https://new.example.com")
        XCTAssertEqual(json["dev_status"] as? String, "completed")
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("PostDevResourceResponse")

        let body = PutDevResourceBody(id: "res3", name: "New Resource")
        let endpoint = PutDevResourceEndpoint(fileId: "test", body: body)
        let resource = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(resource.id, "res3")
        XCTAssertEqual(resource.name, "New Resource")
    }
}
