//
//  W3C_SVG2.Shapes.Rectangle.swift
//  swift-w3c-svg
//
//  The 'rect' element (SVG 2 Section 10.2)
//

extension W3C_SVG2.Shapes {
    /// The 'rect' element
    ///
    /// W3C SVG 2 Section 10.2
    /// https://www.w3.org/TR/SVG2/shapes.html#RectElement
    ///
    /// The 'rect' element defines a rectangle which is axis-aligned with the current user
    /// coordinate system. Rounded rectangles can be achieved by setting appropriate values
    /// for 'rx' and 'ry'.
    ///
    /// ## Geometry Properties
    ///
    /// - **x**: The x-coordinate of the side of the rectangle (default: 0)
    /// - **y**: The y-coordinate of the side of the rectangle (default: 0)
    /// - **width**: The width of the rectangle (must be ≥ 0)
    /// - **height**: The height of the rectangle (must be ≥ 0)
    /// - **rx**: The x-axis radius for rounded corners
    /// - **ry**: The y-axis radius for rounded corners
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Simple rectangle
    /// let rect = W3C_SVG2.Shapes.Rectangle(x: 10, y: 10, width: 100, height: 80)
    ///
    /// // Rounded rectangle
    /// let rounded = W3C_SVG2.Shapes.Rectangle(
    ///     x: 10, y: 10, width: 100, height: 80,
    ///     rx: 5, ry: 5
    /// )
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``Circle``
    /// - ``Ellipse``
    public struct Rectangle: SVGElementType, Sendable, Equatable {
        /// The x-coordinate of the side of the rectangle
        ///
        /// Default value: 0
        public let x: W3C_SVG2.X?

        /// The y-coordinate of the side of the rectangle
        ///
        /// Default value: 0
        public let y: W3C_SVG2.Y?

        /// The width of the rectangle
        ///
        /// A negative value is an error. A value of zero disables rendering.
        public let width: W3C_SVG2.Width?

        /// The height of the rectangle
        ///
        /// A negative value is an error. A value of zero disables rendering.
        public let height: W3C_SVG2.Height?

        /// The x-axis radius for rounded corners
        ///
        /// If not specified, defaults to ry if ry is specified, otherwise 0.
        public let rx: W3C_SVG2.Width?

        /// The y-axis radius for rounded corners
        ///
        /// If not specified, defaults to rx if rx is specified, otherwise 0.
        public let ry: W3C_SVG2.Height?

        /// Creates a rectangle element
        ///
        /// - Parameters:
        ///   - x: The x-coordinate (default: nil, uses 0)
        ///   - y: The y-coordinate (default: nil, uses 0)
        ///   - width: The width (default: nil)
        ///   - height: The height (default: nil)
        ///   - rx: The x-axis corner radius (default: nil)
        ///   - ry: The y-axis corner radius (default: nil)
        public init(
            x: W3C_SVG2.X? = nil,
            y: W3C_SVG2.Y? = nil,
            width: W3C_SVG2.Width? = nil,
            height: W3C_SVG2.Height? = nil,
            rx: W3C_SVG2.Width? = nil,
            ry: W3C_SVG2.Height? = nil
        ) {
            self.x = x
            self.y = y
            self.width = width
            self.height = height
            self.rx = rx
            self.ry = ry
        }

        /// SVG element tag name
        public static let tagName = "rect"

        /// Whether this element is self-closing
        public static let isSelfClosing = false
    }
}
