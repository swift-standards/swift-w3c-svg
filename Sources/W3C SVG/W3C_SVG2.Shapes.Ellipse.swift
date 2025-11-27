//
//  W3C_SVG2.Shapes.Ellipse.swift
//  swift-w3c-svg
//
//  The 'ellipse' element (SVG 2 Section 10.4)
//

extension W3C_SVG2.Shapes {
    /// The 'ellipse' element
    ///
    /// W3C SVG 2 Section 10.4
    /// https://www.w3.org/TR/SVG2/shapes.html#EllipseElement
    ///
    /// The 'ellipse' element defines an ellipse based on a center point and two radii.
    ///
    /// ## Geometry Properties
    ///
    /// - **cx**: The x-axis coordinate of the center of the ellipse (default: 0)
    /// - **cy**: The y-axis coordinate of the center of the ellipse (default: 0)
    /// - **rx**: The x-axis radius of the ellipse (must be ≥ 0)
    /// - **ry**: The y-axis radius of the ellipse (must be ≥ 0)
    ///
    /// ## Example
    ///
    /// ```swift
    /// let ellipse = W3C_SVG2.Shapes.Ellipse(cx: 100, cy: 50, rx: 80, ry: 40)
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``Circle``
    /// - ``Rectangle``
    public struct Ellipse: SVGElementType, Sendable, Equatable {
        /// The x-axis coordinate of the center of the ellipse
        ///
        /// Default value: 0
        public let cx: Double?

        /// The y-axis coordinate of the center of the ellipse
        ///
        /// Default value: 0
        public let cy: Double?

        /// The x-axis radius of the ellipse
        ///
        /// A negative value is an error. A value of zero disables rendering.
        public let rx: Double?

        /// The y-axis radius of the ellipse
        ///
        /// A negative value is an error. A value of zero disables rendering.
        public let ry: Double?

        /// Creates an ellipse element
        ///
        /// - Parameters:
        ///   - cx: The x-axis coordinate of the center (default: nil, uses 0)
        ///   - cy: The y-axis coordinate of the center (default: nil, uses 0)
        ///   - rx: The x-axis radius (default: nil)
        ///   - ry: The y-axis radius (default: nil)
        public init(
            cx: Double? = nil,
            cy: Double? = nil,
            rx: Double? = nil,
            ry: Double? = nil
        ) {
            self.cx = cx
            self.cy = cy
            self.rx = rx
            self.ry = ry
        }

        /// SVG element tag name
        public static let tagName = "ellipse"

        /// Whether this element is self-closing
        public static let isSelfClosing = false
    }
}
