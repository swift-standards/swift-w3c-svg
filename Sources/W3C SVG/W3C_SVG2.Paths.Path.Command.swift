//
//  W3C_SVG2.Paths.Path.Command.swift
//  swift-w3c-svg
//
//  SVG path commands (SVG 2 Section 9)
//

import Formatting
public import Geometry

extension W3C_SVG2.Paths.Path {
    /// SVG path command
    ///
    /// W3C SVG 2 Section 9.3
    /// https://www.w3.org/TR/SVG2/paths.html#PathData
    ///
    /// Represents a single path command in absolute coordinates.
    /// Used as an intermediate representation for parsing and serialization.
    public enum Command: Sendable, Equatable {
        /// Move to point (M)
        case moveTo(W3C_SVG2.Point<W3C_SVG.Space>)

        /// Line to point (L)
        case lineTo(W3C_SVG2.Point<W3C_SVG.Space>)

        /// Horizontal line to x coordinate (H)
        case horizontalLineTo(x: W3C_SVG2.SVGSpace.X)

        /// Vertical line to y coordinate (V)
        case verticalLineTo(y: W3C_SVG2.SVGSpace.Y)

        /// Cubic Bezier curve (C)
        case cubicBezier(W3C_SVG2.Bezier<W3C_SVG.Space>)

        /// Smooth cubic Bezier curve (S)
        case smoothCubicBezier(control2: W3C_SVG2.Point<W3C_SVG.Space>, end: W3C_SVG2.Point<W3C_SVG.Space>)

        /// Quadratic Bezier curve (Q)
        case quadraticBezier(control: W3C_SVG2.Point<W3C_SVG.Space>, end: W3C_SVG2.Point<W3C_SVG.Space>)

        /// Smooth quadratic Bezier curve (T)
        case smoothQuadraticBezier(end: W3C_SVG2.Point<W3C_SVG.Space>)

        /// Elliptical arc (A)
        case arc(Arc)

        /// Close path (Z)
        case closePath
    }
}

// MARK: - Command.Arc

extension W3C_SVG2.Paths.Path.Command {
    /// Elliptical arc command parameters
    ///
    /// W3C SVG 2 Section 9.5.1
    /// https://www.w3.org/TR/SVG2/paths.html#PathDataEllipticalArcCommands
    public struct Arc: Sendable, Equatable {
        /// X radius of the ellipse
        public var rx: Double

        /// Y radius of the ellipse
        public var ry: Double

        /// Rotation of the ellipse in degrees
        public var xAxisRotation: Double

        /// If true, use the larger arc
        public var largeArcFlag: Bool

        /// If true, arc is drawn in positive-angle direction
        public var sweepFlag: Bool

        /// The endpoint of the arc
        public var end: W3C_SVG2.Point<W3C_SVG.Space>

        /// Creates an arc command.
        ///
        /// - Parameters:
        ///   - rx: X radius of the ellipse
        ///   - ry: Y radius of the ellipse
        ///   - xAxisRotation: Rotation of the ellipse in degrees
        ///   - largeArcFlag: If true, use the larger arc
        ///   - sweepFlag: If true, arc is drawn in positive-angle direction
        ///   - end: The endpoint of the arc
        public init(
            rx: Double,
            ry: Double,
            xAxisRotation: Double,
            largeArcFlag: Bool,
            sweepFlag: Bool,
            end: W3C_SVG2.Point<W3C_SVG.Space>
        ) {
            self.rx = rx
            self.ry = ry
            self.xAxisRotation = xAxisRotation
            self.largeArcFlag = largeArcFlag
            self.sweepFlag = sweepFlag
            self.end = end
        }

        /// Convert to a `Geometry.Ellipse.Arc` for proper geometric operations.
        ///
        /// - Parameter from: The starting point of the arc
        /// - Returns: The elliptical arc in center parameterization
        public func toEllipseArc(from: W3C_SVG2.Point<W3C_SVG.Space>) -> W3C_SVG2.Ellipse<W3C_SVG.Space>.Arc {
            // Convert degrees to radians for rotation
            let rotationRadians = Radian(xAxisRotation * .pi / 180)

            return W3C_SVG2.Ellipse<W3C_SVG.Space>.Arc(
                from: from,
                to: end,
                rx: W3C_SVG2.SVGSpace.Length(rx),
                ry: W3C_SVG2.SVGSpace.Length(ry),
                xAxisRotation: rotationRadians,
                largeArcFlag: largeArcFlag,
                sweepFlag: sweepFlag
            )
        }

        /// Convert the arc command to Bezier curves.
        ///
        /// - Parameter from: The starting point of the arc
        /// - Returns: Array of Bezier curves approximating the arc
        public func toBeziers(from: W3C_SVG2.Point<W3C_SVG.Space>) -> [W3C_SVG2.Bezier<W3C_SVG.Space>] {
            // Handle degenerate cases
            guard rx > 0 && ry > 0 else {
                return [.linear(from: from, to: end)]
            }

            // If endpoints are the same, no arc needed
            if from == end {
                return []
            }

            // Convert to Geometry.Ellipse.Arc and use its bezier conversion
            let ellipseArc = toEllipseArc(from: from)
            return [W3C_SVG2.Bezier<W3C_SVG.Space>](ellipticalArc: ellipseArc)
        }
    }
}

// MARK: - Command Serialization

extension W3C_SVG2.Paths.Path.Command: CustomStringConvertible {
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
