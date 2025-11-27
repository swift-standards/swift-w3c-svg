//
//  W3C_SVG2.Shapes.Circle.swift
//  swift-w3c-svg
//
//  The 'circle' element (SVG 2 Section 10.3)
//

extension W3C_SVG2.Shapes {
    /// The 'circle' element
    ///
    /// W3C SVG 2 Section 10.3
    /// https://www.w3.org/TR/SVG2/shapes.html#CircleElement
    ///
    /// The 'circle' element defines a circle based on a center point and a radius.
    ///
    /// ## Geometry Properties
    ///
    /// - **cx**: The x-axis coordinate of the center of the circle (default: 0)
    /// - **cy**: The y-axis coordinate of the center of the circle (default: 0)
    /// - **r**: The radius of the circle (must be ≥ 0)
    ///
    /// A negative value for 'r' is an error. A value of zero disables rendering of the element.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let circle = W3C_SVG2.Shapes.Circle(cx: 50, cy: 50, r: 40)
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``Ellipse``
    /// - ``Rectangle``
    public struct Circle: SVGElementType, Sendable, Equatable {
        /// The x-axis coordinate of the center of the circle
        ///
        /// Default value: 0
        public let cx: Double?

        /// The y-axis coordinate of the center of the circle
        ///
        /// Default value: 0
        public let cy: Double?

        /// The radius of the circle
        ///
        /// A negative value is an error. A value of zero disables rendering.
        /// Default value: 0
        public let r: Double?

        /// Creates a circle element
        ///
        /// - Parameters:
        ///   - cx: The x-axis coordinate of the center (default: nil, uses 0)
        ///   - cy: The y-axis coordinate of the center (default: nil, uses 0)
        ///   - r: The radius (default: nil, uses 0)
        public init(cx: Double? = nil, cy: Double? = nil, r: Double? = nil) {
            self.cx = cx
            self.cy = cy
            self.r = r
        }

        /// SVG element tag name
        public static let tagName = "circle"

        /// Whether this element is self-closing
        public static let isSelfClosing = false
    }
}
