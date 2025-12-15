//
//  W3C_SVG2.Shapes.Line.swift
//  swift-w3c-svg
//
//  The 'line' element (SVG 2 Section 10.5)
//

extension W3C_SVG2.Shapes {
    /// The 'line' element
    ///
    /// W3C SVG 2 Section 10.5
    /// https://www.w3.org/TR/SVG2/shapes.html#LineElement
    ///
    /// The 'line' element defines a line segment that starts at one point and ends at another.
    ///
    /// ## Geometry Properties
    ///
    /// - **x1**: The x-coordinate of the start point (default: 0)
    /// - **y1**: The y-coordinate of the start point (default: 0)
    /// - **x2**: The x-coordinate of the end point (default: 0)
    /// - **y2**: The y-coordinate of the end point (default: 0)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let line = W3C_SVG2.Shapes.Line(x1: 0, y1: 0, x2: 100, y2: 100)
    /// ```
    public struct Line: SVGElementType, Sendable, Equatable {
        /// The x-coordinate of the start point
        public let x1: W3C_SVG2.X?

        /// The y-coordinate of the start point
        public let y1: W3C_SVG2.Y?

        /// The x-coordinate of the end point
        public let x2: W3C_SVG2.X?

        /// The y-coordinate of the end point
        public let y2: W3C_SVG2.Y?

        /// Creates a line element
        ///
        /// - Parameters:
        ///   - x1: The x-coordinate of the start point (default: nil, uses 0)
        ///   - y1: The y-coordinate of the start point (default: nil, uses 0)
        ///   - x2: The x-coordinate of the end point (default: nil, uses 0)
        ///   - y2: The y-coordinate of the end point (default: nil, uses 0)
        public init(
            x1: W3C_SVG2.X? = nil,
            y1: W3C_SVG2.Y? = nil,
            x2: W3C_SVG2.X? = nil,
            y2: W3C_SVG2.Y? = nil
        ) {
            self.x1 = x1
            self.y1 = y1
            self.x2 = x2
            self.y2 = y2
        }

        /// SVG element tag name
        public static let tagName = "line"

        /// Whether this element is self-closing
        public static let isSelfClosing = false
    }
}
