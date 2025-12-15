//
//  W3C_SVG2.Shapes.Polygon.swift
//  swift-w3c-svg
//
//  The 'polygon' element (SVG 2 Section 10.7)
//

import Formatting

extension W3C_SVG2.Shapes {
    /// The 'polygon' element
    ///
    /// W3C SVG 2 Section 10.7
    /// https://www.w3.org/TR/SVG2/shapes.html#PolygonElement
    ///
    /// The 'polygon' element defines a closed shape consisting of a set of
    /// connected straight line segments.
    ///
    /// ## Geometry Properties
    ///
    /// - **points**: A list of coordinate pairs defining the polygon path
    ///
    /// ## Behavior
    ///
    /// Unlike polylines, polygons automatically close by performing a closepath
    /// command after connecting all vertices, creating a sealed geometric form.
    /// If an odd number of coordinates is supplied, the final coordinate is dropped.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Triangle
    /// let triangle = W3C_SVG2.Shapes.Polygon(points: "50,0 100,100 0,100")
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``Polyline``
    /// - ``Line``
    public struct Polygon: SVGElementType, Sendable, Equatable {
        /// A list of coordinate pairs defining the polygon path
        ///
        /// Format: space or comma-separated list of coordinate pairs (x,y)
        /// Example: "50,0 100,100 0,100" or "50 0 100 100 0 100"
        ///
        /// The polygon automatically closes from the last point to the first.
        public let points: String?

        /// Creates a polygon element
        ///
        /// - Parameters:
        ///   - points: A list of coordinate pairs (default: nil)
        public init(
            points: String? = nil
        ) {
            self.points = points
        }

        /// Creates a polygon element from coordinate tuples
        ///
        /// - Parameters:
        ///   - coordinates: Array of (x, y) coordinate tuples
        public init(coordinates: [(Double, Double)]) {
            self.points = coordinates.map { "\($0.0.formatted(.number)),\($0.1.formatted(.number))" }.joined(separator: " ")
        }

        /// SVG element tag name
        public static let tagName = "polygon"

        /// Whether this element is self-closing
        public static let isSelfClosing = false
    }
}
