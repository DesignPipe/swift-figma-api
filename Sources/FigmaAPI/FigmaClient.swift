import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public final class FigmaClient: BaseClient, @unchecked Sendable {
    // swiftlint:disable:next force_unwrapping
    public static let baseURL = URL(string: "https://api.figma.com/")!

    public init(accessToken: String, timeout: TimeInterval?) {
        let config = URLSessionConfiguration.ephemeral
        config.httpAdditionalHeaders = ["X-Figma-Token": accessToken]
        config.timeoutIntervalForRequest = timeout ?? 30
        super.init(baseURL: Self.baseURL, config: config)
    }
}
