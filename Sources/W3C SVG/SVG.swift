//
//  SVG.swift
//  swift-w3c-svg
//
//  User-facing SVG namespace for geometry types.
//

/// SVG namespace providing type-safe geometry primitives for SVG coordinate space.
///
/// This namespace offers a clean, ergonomic API for working with SVG geometry:
///
/// ```swift
/// let circle = SVG.Circle(center: SVG.Point(x: 100, y: 100), radius: 50)
/// let rect = SVG.Rectangle(x: 0, y: 0, width: 200, height: 100)
/// ```
///
/// All types are parameterized with `W3C_SVG.Space` for type-safe coordinate handling.
public enum SVG {}

// MARK: - Underlying Type

extension SVG {
    /// The underlying geometry type specialized for SVG coordinate space.
    public typealias Space = Geometry<Double, W3C_SVG.Space>
}

// MARK: - Geometry Primitives

extension SVG {
    /// A circle in SVG coordinate space.
    public typealias Circle = Space.Circle

    /// A rectangle in SVG coordinate space.
    public typealias Rectangle = Space.Rectangle

    /// An ellipse in SVG coordinate space.
    public typealias Ellipse = Space.Ellipse

    /// A line segment in SVG coordinate space.
    public typealias Line = Space.Line.Segment

    /// A polygon in SVG coordinate space.
    public typealias Polygon = Space.Polygon

    /// A path in SVG coordinate space.
    public typealias Path = Space.Path

    /// An arc in SVG coordinate space.
    public typealias Arc = Space.Arc

    /// A Bezier curve in SVG coordinate space.
    public typealias Bezier = Space.Bezier

    /// A triangle in SVG coordinate space.
    public typealias Triangle = Space.Triangle
}

// MARK: - Coordinate Types

extension SVG {
    /// X coordinate in SVG space.
    public typealias X = Space.X

    /// Y coordinate in SVG space.
    public typealias Y = Space.Y

    /// X displacement in SVG space.
    public typealias Dx = Space.Dx

    /// Y displacement in SVG space.
    public typealias Dy = Space.Dy

    /// Width extent in SVG space.
    public typealias Width = Space.Width

    /// Height extent in SVG space.
    public typealias Height = Space.Height

    /// Radius in SVG space.
    public typealias Radius = Space.Radius

    /// A 2D point in SVG coordinate space.
    public typealias Point = Space.Point<2>

    /// A 2D displacement vector in SVG coordinate space.
    public typealias Vector = Space.Vector<2>
}

// MARK: - Transform

extension SVG {
    /// An affine transformation in SVG coordinate space.
    public typealias Transform = Space.AffineTransform
}
