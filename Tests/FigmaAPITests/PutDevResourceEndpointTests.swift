@testable import FigmaAPI
import XCTest

final class PutDevResourceEndpointTests: XCTestCase {
    // MARK: - URL Construction

    func testMakeRequestConstructsCorrectURL() throws {
        let body = PutDevResourceBody(id: "res1", name: "Updated")
        let endpoint = PutDevResourceEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(
            request.url?.absoluteString,
            "https://api.figma.com/v1/dev_resources"
        )
    }

    func testMakeRequestUsesPUTMethod() throws {
        let body = PutDevResourceBody(id: "res1", name: "Updated")
        let endpoint = PutDevResourceEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.httpMethod, "PUT")
    }

    func testMakeRequestSetsContentTypeHeader() throws {
        let body = PutDevResourceBody(id: "res1", name: "Updated")
        let endpoint = PutDevResourceEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    func testMakeRequestWrapsBodyInDevResourcesArray() throws {
        let body = PutDevResourceBody(id: "res1", name: "Updated Name", url: "https://new.example.com")
        let endpoint = PutDevResourceEndpoint(body: body)
        let baseURL = try XCTUnwrap(URL(string: "https://api.figma.com/"))

        let request = try endpoint.makeRequest(baseURL: baseURL)

        let httpBody = try XCTUnwrap(request.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: httpBody) as? [String: Any])
        let devResources = try XCTUnwrap(json["dev_resources"] as? [[String: Any]])
        XCTAssertEqual(devResources.count, 1)
        XCTAssertEqual(devResources[0]["id"] as? String, "res1")
        XCTAssertEqual(devResources[0]["name"] as? String, "Updated Name")
        XCTAssertEqual(devResources[0]["url"] as? String, "https://new.example.com")
    }

    // MARK: - Response Parsing

    func testContentParsesResponse() throws {
        let data = try FixtureLoader.loadData("PutDevResourceResponse")

        let body = PutDevResourceBody(id: "res1", name: "Updated Name")
        let endpoint = PutDevResourceEndpoint(body: body)
        let resources = try endpoint.content(from: nil, with: data)

        XCTAssertEqual(resources.count, 1)
        XCTAssertEqual(resources[0].id, "res1")
        XCTAssertEqual(resources[0].name, "Updated Name")
    }

    // MARK: - Error Handling

    func testContentThrowsOnInvalidJSON() {
        let invalidData = Data("invalid".utf8)
        let body = PutDevResourceBody(id: "res1", name: "Test")
        let endpoint = PutDevResourceEndpoint(body: body)

        XCTAssertThrowsError(try endpoint.content(from: nil, with: invalidData))
    }
}
