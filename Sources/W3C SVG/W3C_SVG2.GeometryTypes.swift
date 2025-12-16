//
//  W3C_SVG2.GeometryTypes.swift
//  swift-w3c-svg
//
//  Re-exports Geometry module and provides type aliases.
//
//  RECOMMENDED: Use the SVG namespace for geometry types:
//  - SVG.Circle, SVG.Rectangle, SVG.Ellipse, SVG.Line, etc.
//  - SVG.Point, SVG.Vector, SVG.Path, etc.
//

@_exported public import Geometry

// MARK: - Generic Geometry Type Aliases

extension W3C_SVG2 {
    /// A generic 2D point parameterized by coordinate space.
    ///
    /// **Prefer using `SVG.Point` for new code.**
    public typealias Point<Space> = Geometry<Double, Space>.Point<2>

    /// A generic 2D displacement vector parameterized by coordinate space.
    ///
    /// **Prefer using `SVG.Vector` for new code.**
    public typealias Vector<Space> = Geometry<Double, Space>.Vector<2>

    /// A generic Bezier curve parameterized by coordinate space.
    ///
    /// **Prefer using `SVG.Bezier` for new code.**
    public typealias Bezier<Space> = Geometry<Double, Space>.Bezier

    /// A generic ellipse parameterized by coordinate space.
    ///
    /// **Prefer using `SVG.Ellipse` for new code.**
    public typealias Ellipse<Space> = Geometry<Double, Space>.Ellipse

    /// A generic arc parameterized by coordinate space.
    ///
    /// **Prefer using `SVG.Arc` for new code.**
    public typealias Arc<Space> = Geometry<Double, Space>.Arc

    /// A generic line segment parameterized by coordinate space.
    ///
    /// **Prefer using `SVG.Line` for new code.**
    public typealias LineSegment<Space> = Geometry<Double, Space>.Line.Segment

    /// A path geometry parameterized by coordinate space.
    ///
    /// **Prefer using `SVG.Path` for new code.**
    public typealias PathGeometry<Space> = Geometry<Double, Space>.Path

    /// SVG coordinate space geometry.
    ///
    /// **Prefer using `SVG.Space` for new code.**
    public typealias SVGSpace = Geometry<Double, W3C_SVG.Space>
}

// MARK: - Coordinate Types

extension W3C_SVG2 {
    /// X coordinate in SVG space.
    public typealias X = SVG.X

    /// Y coordinate in SVG space.
    public typealias Y = SVG.Y

    /// Width extent in SVG space.
    public typealias Width = SVG.Width

    /// Height extent in SVG space.
    public typealias Height = SVG.Height

    /// X displacement in SVG space.
    public typealias Dx = SVG.Dx

    /// Y displacement in SVG space.
    public typealias Dy = SVG.Dy

    /// Radius in SVG space.
    public typealias Radius = SVG.Radius

    /// Angle in degrees (for transforms and rotations).
    public typealias Degrees = Degree<Double>
}
