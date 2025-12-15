//
//  W3C_SVG2.Paths.Path.swift
//  swift-w3c-svg
//
//  The 'path' element (SVG 2 Section 9)
//

import Formatting
public import Geometry

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
    /// - **commands**: Parsed path commands as `[PathCommand]`
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
    /// // From path data string
    /// let triangle = W3C_SVG2.Paths.Path(d: "M 100 100 L 300 100 L 200 300 Z")
    ///
    /// // Access parsed commands
    /// for command in triangle.commands {
    ///     switch command {
    ///     case .moveTo(let point):
    ///         print("Move to \(point)")
    ///     case .lineTo(let point):
    ///         print("Line to \(point)")
    ///     case .closePath:
    ///         print("Close path")
    ///     default:
    ///         break
    ///     }
    /// }
    ///
    /// // From commands directly
    /// let square = W3C_SVG2.Paths.Path(commands: [
    ///     .moveTo(W3C_SVG2.Point<W3C_SVG.Space>(x: .init(0), y: .init(0))),
    ///     .lineTo(W3C_SVG2.Point<W3C_SVG.Space>(x: .init(100), y: .init(0))),
    ///     .lineTo(W3C_SVG2.Point<W3C_SVG.Space>(x: .init(100), y: .init(100))),
    ///     .lineTo(W3C_SVG2.Point<W3C_SVG.Space>(x: .init(0), y: .init(100))),
    ///     .closePath
    /// ])
    /// ```
    ///
    /// ## See Also
    ///
    /// - ``W3C_SVG2.Shapes``
    /// - ``PathCommand``
    /// - ``PathParser``
    public struct Path: SVGElementType, Sendable, Equatable {
        /// The underlying path geometry from swift-standards.
        public var geometry: W3C_SVG2.PathGeometry<W3C_SVG.Space>

        /// The fill rule for determining path interior
        ///
        /// Default value: nonzero
        public var fillRule: W3C_SVG2.Painting.FillRule?

        /// The path data string (serialized from geometry).
        ///
        /// Returns a serialized version of the path in SVG path data format.
        public var d: String? {
            guard !geometry.isEmpty else { return nil }
            return PathSerializer.serialize(geometry)
        }

        /// Creates a path element from a path data string.
        ///
        /// - Parameters:
        ///   - d: The path data string (default: nil)
        ///   - fillRule: The fill rule (default: nil, uses nonzero)
        public init(d: String? = nil, fillRule: W3C_SVG2.Painting.FillRule? = nil) {
            if let d = d {
                self.geometry = PathParser.parse(d)
            } else {
                self.geometry = .init(subpaths: [])
            }
            self.fillRule = fillRule
        }

        /// Creates a path element from geometry directly.
        ///
        /// - Parameters:
        ///   - geometry: The path geometry
        ///   - fillRule: The fill rule (default: nil, uses nonzero)
        public init(
            geometry: W3C_SVG2.PathGeometry<W3C_SVG.Space>,
            fillRule: W3C_SVG2.Painting.FillRule? = nil
        ) {
            self.geometry = geometry
            self.fillRule = fillRule
        }

        /// SVG element tag name
        public static let tagName = "path"

        /// Whether this element is self-closing
        public static let isSelfClosing = false
    }
}

// MARK: - PathCommand Serialization

extension W3C_SVG2.Paths.PathCommand: CustomStringConvertible {
    public var description: String {
        switch self {
        case .moveTo(let point):
            return "M \(point.x._rawValue.formatted(.number)) \(point.y._rawValue.formatted(.number))"

        case .lineTo(let point):
            return "L \(point.x._rawValue.formatted(.number)) \(point.y._rawValue.formatted(.number))"

        case .horizontalLineTo(let x):
            return "H \(x._rawValue.formatted(.number))"

        case .verticalLineTo(let y):
            return "V \(y._rawValue.formatted(.number))"

        case .cubicBezier(let bezier):
            guard bezier.controlPoints.count >= 4 else { return "" }
            let c1 = bezier.controlPoints[1]
            let c2 = bezier.controlPoints[2]
            let end = bezier.controlPoints[3]
            return "C \(c1.x._rawValue.formatted(.number)) \(c1.y._rawValue.formatted(.number)) \(c2.x._rawValue.formatted(.number)) \(c2.y._rawValue.formatted(.number)) \(end.x._rawValue.formatted(.number)) \(end.y._rawValue.formatted(.number))"

        case .smoothCubicBezier(let control2, let end):
            return "S \(control2.x._rawValue.formatted(.number)) \(control2.y._rawValue.formatted(.number)) \(end.x._rawValue.formatted(.number)) \(end.y._rawValue.formatted(.number))"

        case .quadraticBezier(let control, let end):
            return "Q \(control.x._rawValue.formatted(.number)) \(control.y._rawValue.formatted(.number)) \(end.x._rawValue.formatted(.number)) \(end.y._rawValue.formatted(.number))"

        case .smoothQuadraticBezier(let end):
            return "T \(end.x._rawValue.formatted(.number)) \(end.y._rawValue.formatted(.number))"

        case .arc(let arc):
            let largeArc = arc.largeArcFlag ? "1" : "0"
            let sweep = arc.sweepFlag ? "1" : "0"
            return "A \(arc.rx.formatted(.number)) \(arc.ry.formatted(.number)) \(arc.xAxisRotation.formatted(.number)) \(largeArc) \(sweep) \(arc.end.x._rawValue.formatted(.number)) \(arc.end.y._rawValue.formatted(.number))"

        case .closePath:
            return "Z"
        }
    }
}
