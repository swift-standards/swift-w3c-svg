//
//  W3C_SVG2.Types.ViewBox.swift
//  swift-w3c-svg
//
//  SVG viewBox attribute (SVG 2 Section 8.2)
//

import Numeric_Formatting

extension W3C_SVG2.Types {
    /// SVG viewBox value
    ///
    /// W3C SVG 2 Section 8.2
    /// https://www.w3.org/TR/SVG2/coords.html#ViewBoxAttribute
    ///
    /// The viewBox attribute defines the position and dimension, in user space,
    /// of an SVG viewport.
    ///
    /// The value of the viewBox attribute is a list of four numbers: min-x, min-y,
    /// width and height.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let vb = W3C_SVG2.Types.ViewBox(minX: 0, minY: 0, width: 100, height: 200)
    /// // Outputs: "0 0 100 200"
    /// ```
    public struct ViewBox: Sendable, Equatable {
        /// The minimum x-coordinate
        public let minX: Double

        /// The minimum y-coordinate
        public let minY: Double

        /// The width of the viewport
        public let width: Double

        /// The height of the viewport
        public let height: Double

        /// Creates a viewBox value
        ///
        /// - Parameters:
        ///   - minX: Minimum x-coordinate (default: 0)
        ///   - minY: Minimum y-coordinate (default: 0)
        ///   - width: Width of viewport
        ///   - height: Height of viewport
        public init(minX: Double = 0, minY: Double = 0, width: Double, height: Double) {
            self.minX = minX
            self.minY = minY
            self.width = width
            self.height = height
        }

        /// String representation for SVG output
        public var stringValue: String {
            "\(minX.formatted(.number)) \(minY.formatted(.number)) \(width.formatted(.number)) \(height.formatted(.number))"
        }
    }
}
