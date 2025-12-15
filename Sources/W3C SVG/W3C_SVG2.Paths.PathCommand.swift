//
//  W3C_SVG2.Paths.PathCommand.swift
//  swift-w3c-svg
//
//  SVG path commands (SVG 2 Section 9)
//

public import Geometry

extension W3C_SVG2.Paths {
    /// SVG path command
    ///
    /// W3C SVG 2 Section 9.3
    /// https://www.w3.org/TR/SVG2/paths.html#PathData
    ///
    /// Represents a single path command in absolute coordinates.
    public enum PathCommand: Sendable, Equatable {
        /// Move to point (M)
        case moveTo(W3C_SVG2.Point<W3C_SVG.Space>)

        /// Line to point (L)
        case lineTo(W3C_SVG2.Point<W3C_SVG.Space>)

        /// Horizontal line to x coordinate (H)
        case horizontalLineTo(x: Double)

        /// Vertical line to y coordinate (V)
        case verticalLineTo(y: Double)

        /// Cubic Bezier curve (C)
        case cubicBezier(W3C_SVG2.Bezier<W3C_SVG.Space>)

        /// Smooth cubic Bezier curve (S)
        case smoothCubicBezier(control2: W3C_SVG2.Point<W3C_SVG.Space>, end: W3C_SVG2.Point<W3C_SVG.Space>)

        /// Quadratic Bezier curve (Q)
        case quadraticBezier(control: W3C_SVG2.Point<W3C_SVG.Space>, end: W3C_SVG2.Point<W3C_SVG.Space>)

        /// Smooth quadratic Bezier curve (T)
        case smoothQuadraticBezier(end: W3C_SVG2.Point<W3C_SVG.Space>)

        /// Elliptical arc (A)
        case arc(ArcCommand)

        /// Close path (Z)
        case closePath
    }

    /// Elliptical arc command parameters
    ///
    /// W3C SVG 2 Section 9.5.1
    /// https://www.w3.org/TR/SVG2/paths.html#PathDataEllipticalArcCommands
    public struct ArcCommand: Sendable, Equatable {
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

            // Convert to center parameterization and create arc
            // This is a simplified implementation - full SVG arc conversion is complex
            // For now, return a cubic bezier approximation
            let midX = W3C_SVG2.SVGSpace.X((from.x._rawValue + end.x._rawValue) / 2)
            let midY = W3C_SVG2.SVGSpace.Y((from.y._rawValue + end.y._rawValue) / 2)
            let midPoint = W3C_SVG2.Point<W3C_SVG.Space>(x: midX, y: midY)

            // Simple quadratic approximation through midpoint
            return [W3C_SVG2.Bezier<W3C_SVG.Space>.quadratic(from: from, control: midPoint, to: end)]
        }
    }
}
