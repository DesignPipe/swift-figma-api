import Foundation

extension Error {
    /// Returns the best available description of the error.
    ///
    /// Uses `description` from `CustomStringConvertible` if available,
    /// otherwise falls back to `localizedDescription`.
    var bestDescription: String {
        (self as any CustomStringConvertible).description
    }
}
