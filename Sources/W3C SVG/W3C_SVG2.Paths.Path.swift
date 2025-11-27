//
//  W3C_SVG2.Paths.Path.swift
//  swift-w3c-svg
//
//  The 'path' element (SVG 2 Section 9)
//

extension W3C_SVG2.Paths {
    /// The 'path' element
    ///
    /// W3C SVG 2 Section 9
    /// https://www.w3.org/TR/SVG2/paths.html#PathElement
    ///
    /// The 'path' element defines a shape using SVG path data commands.
    /// Path data consists of moveto, lineto, curveto, arc, and closepath commands.
    ///
    /// ## Path Data
    ///
    /// - **d**: A string containing a series of path commands and parameters
    ///
    /// Path commands:
    /// - M/m: moveto
    /// - L/l: lineto
    /// - H/h: horizontal lineto
    /// - V/v: vertical lineto
    /// - C/c: cubic Bézier curve
    /// - S/s: smooth cubic Bézier curve
    /// - Q/q: quadratic Bézier curve
    /// - T/t: smooth quadratic Bézier curve
    /// - A/a: elliptical arc
    /// - Z/z: closepath
    ///
    /// ## Fill Rule
    ///
    /// - **fillRule**: Determines how the interior of the shape is determined (nonzero or evenodd)
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Triangle
    /// let triangle = W3C_SVG2.Paths.Path(d: "M 100 100 L 300 100 L 200 300 Z")
    ///
    /// // Cubic Bézier curve
    /// let curve = W3C_SVG2.Paths.Path(
    ///     d: "M 100 200 C 100 100, 250 100, 250 200",
    ///     fillRule: .evenodd
    /// )
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``W3C_SVG2.Shapes``
    public struct Path: SVGElementType, Sendable, Equatable {
        /// The path data defining the shape
        ///
        /// A string containing a series of path commands and parameters.
        /// Commands can be absolute (uppercase) or relative (lowercase).
        public let d: String?

        /// The fill rule for determining path interior
        ///
        /// Default value: nonzero
        public let fillRule: W3C_SVG2.Painting.FillRule?

        /// Creates a path element
        ///
        /// - Parameters:
        ///   - d: The path data string (default: nil)
        ///   - fillRule: The fill rule (default: nil, uses nonzero)
        public init(d: String? = nil, fillRule: W3C_SVG2.Painting.FillRule? = nil) {
            self.d = d
            self.fillRule = fillRule
        }

        /// SVG element tag name
        public static let tagName = "path"

        /// Whether this element is self-closing
        public static let isSelfClosing = false
    }
}
