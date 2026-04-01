/// A path geometry returned by the Figma API when `geometry=paths` is used.
///
/// Contains the SVG path command string and winding rule.
/// See: https://developers.figma.com/docs/rest-api/file-property-types/#path-type
public struct VectorPath: Decodable, Sendable {
    /// A series of SVG path commands that encodes how to draw the path.
    public let path: String

    /// The winding rule for the path (same as in SVGs).
    public let windingRule: WindingRule

    /// If there is a per-region fill, this refers to an ID in the fillOverrideTable.
    public let overrideID: Int?
}

/// SVG winding rule for vector paths.
public enum WindingRule: String, Decodable, Sendable {
    case nonZero = "NONZERO"
    case evenOdd = "EVENODD"
}
