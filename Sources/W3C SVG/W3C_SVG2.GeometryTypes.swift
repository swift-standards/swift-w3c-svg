//
//  W3C_SVG2.GeometryTypes.swift
//  swift-w3c-svg
//
//  Type aliases for SVG geometry types from swift-standards
//

@_exported public import Geometry

// MARK: - Generic Geometry Type Aliases

extension W3C_SVG2 {
    /// A generic 2D point parameterized by coordinate space.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let point: W3C_SVG2.Point<W3C_SVG.Space> = .init(x: .init(100), y: .init(100))
    /// ```
    public typealias Point<Space> = Geometry<Double, Space>.Point<2>

    /// A generic 2D displacement vector parameterized by coordinate space.
    public typealias Vector<Space> = Geometry<Double, Space>.Vector<2>

    /// A generic rectangle parameterized by coordinate space.
    public typealias Rectangle<Space> = Geometry<Double, Space>.Rectangle

    /// A generic Bezier curve parameterized by coordinate space.
    public typealias Bezier<Space> = Geometry<Double, Space>.Bezier

    /// A generic arc parameterized by coordinate space.
    public typealias Arc<Space> = Geometry<Double, Space>.Arc

    /// A generic ellipse parameterized by coordinate space.
    public typealias Ellipse<Space> = Geometry<Double, Space>.Ellipse

    /// A generic line segment parameterized by coordinate space.
    public typealias LineSegment<Space> = Geometry<Double, Space>.Line.Segment

    /// A generic path parameterized by coordinate space.
    public typealias PathGeometry<Space> = Geometry<Double, Space>.Path

    /// A generic affine transform parameterized by coordinate space.
    public typealias AffineTransform<Space> = Geometry<Double, Space>.AffineTransform
}

// MARK: - SVG Space Specialization

extension W3C_SVG2 {
    /// Complete SVG coordinate space geometry.
    ///
    /// Provides access to all geometry primitives specialized for SVG coordinate space.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let point: W3C_SVG2.SVGSpace.Point<2> = .init(x: .init(100), y: .init(100))
    /// let rect: W3C_SVG2.SVGSpace.Rectangle = .init(...)
    /// ```
    public typealias SVGSpace = Geometry<Double, W3C_SVG.Space>
}

// MARK: - SVG Space Convenience Extensions

extension W3C_SVG2.SVGSpace {
    /// 2D point in SVG coordinate space (convenience).
    public typealias Coordinate = W3C_SVG2.Point<W3C_SVG.Space>
}

// MARK: - Top-Level Type Aliases

extension W3C_SVG2 {
    /// X coordinate in SVG space
    public typealias X = SVGSpace.X

    /// Y coordinate in SVG space
    public typealias Y = SVGSpace.Y

    /// Width extent in SVG space
    public typealias Width = SVGSpace.Width

    /// Height extent in SVG space
    public typealias Height = SVGSpace.Height

    /// X displacement in SVG space
    public typealias Dx = SVGSpace.Dx

    /// Y displacement in SVG space
    public typealias Dy = SVGSpace.Dy

    /// Radius in SVG space
    public typealias Radius = SVGSpace.Radius

    /// Angle in degrees (for transforms and rotations)
    public typealias Degrees = Degree<Double>
}
