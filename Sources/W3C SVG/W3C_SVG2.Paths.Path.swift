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
        /// The parsed path commands.
        public var commands: [PathCommand]

        /// The fill rule for determining path interior
        ///
        /// Default value: nonzero
        public var fillRule: W3C_SVG2.Painting.FillRule?

        /// The path data string (computed from commands).
        ///
        /// Returns a serialized version of the commands in SVG path data format.
        public var d: String? {
            guard !commands.isEmpty else { return nil }
            return commands.map { $0.description }.joined(separator: " ")
        }

        /// Creates a path element from a path data string.
        ///
        /// - Parameters:
        ///   - d: The path data string (default: nil)
        ///   - fillRule: The fill rule (default: nil, uses nonzero)
        public init(d: String? = nil, fillRule: W3C_SVG2.Painting.FillRule? = nil) {
            if let d = d {
                self.commands = PathParser.parse(d)
            } else {
                self.commands = []
            }
            self.fillRule = fillRule
        }

        /// Creates a path element from commands directly.
        ///
        /// - Parameters:
        ///   - commands: The path commands
        ///   - fillRule: The fill rule (default: nil, uses nonzero)
        public init(commands: [PathCommand], fillRule: W3C_SVG2.Painting.FillRule? = nil) {
            self.commands = commands
            self.fillRule = fillRule
        }

        /// Convert the path to Bezier curves.
        ///
        /// This flattens the path into a series of Bezier curves that can be
        /// used for rendering or geometric operations.
        ///
        /// - Returns: Array of Bezier curves representing the path
        public func toBezierPath() -> [W3C_SVG2.Bezier<W3C_SVG.Space>] {
            var beziers: [W3C_SVG2.Bezier<W3C_SVG.Space>] = []
            var currentPoint: W3C_SVG2.Point<W3C_SVG.Space> = .init(x: .init(0), y: .init(0))
            var startPoint: W3C_SVG2.Point<W3C_SVG.Space> = currentPoint
            var lastControlPoint: W3C_SVG2.Point<W3C_SVG.Space>?

            for command in commands {
                switch command {
                case .moveTo(let point):
                    currentPoint = point
                    startPoint = point
                    lastControlPoint = nil

                case .lineTo(let point):
                    beziers.append(.linear(from: currentPoint, to: point))
                    currentPoint = point
                    lastControlPoint = nil

                case .horizontalLineTo(let x):
                    let point = W3C_SVG2.Point<W3C_SVG.Space>(
                        x: W3C_SVG2.SVGSpace.X(x),
                        y: currentPoint.y
                    )
                    beziers.append(.linear(from: currentPoint, to: point))
                    currentPoint = point
                    lastControlPoint = nil

                case .verticalLineTo(let y):
                    let point = W3C_SVG2.Point<W3C_SVG.Space>(
                        x: currentPoint.x,
                        y: W3C_SVG2.SVGSpace.Y(y)
                    )
                    beziers.append(.linear(from: currentPoint, to: point))
                    currentPoint = point
                    lastControlPoint = nil

                case .cubicBezier(let bezier):
                    beziers.append(bezier)
                    if let end = bezier.endPoint {
                        currentPoint = end
                    }
                    if bezier.controlPoints.count >= 3 {
                        lastControlPoint = bezier.controlPoints[bezier.controlPoints.count - 2]
                    }

                case .smoothCubicBezier(let control2, let end):
                    // Reflect last control point to get control1
                    // Reflection formula: new = current + (current - last)
                    let control1: W3C_SVG2.Point<W3C_SVG.Space>
                    if let last = lastControlPoint {
                        let newX = currentPoint.x + (currentPoint.x - last.x)
                        let newY = currentPoint.y + (currentPoint.y - last.y)
                        control1 = W3C_SVG2.Point<W3C_SVG.Space>(x: newX, y: newY)
                    } else {
                        control1 = currentPoint
                    }
                    let bezier = W3C_SVG2.Bezier<W3C_SVG.Space>.cubic(
                        from: currentPoint,
                        control1: control1,
                        control2: control2,
                        to: end
                    )
                    beziers.append(bezier)
                    lastControlPoint = control2
                    currentPoint = end

                case .quadraticBezier(let control, let end):
                    let bezier = W3C_SVG2.Bezier<W3C_SVG.Space>.quadratic(
                        from: currentPoint,
                        control: control,
                        to: end
                    )
                    beziers.append(bezier)
                    lastControlPoint = control
                    currentPoint = end

                case .smoothQuadraticBezier(let end):
                    // Reflection formula: new = current + (current - last)
                    let control: W3C_SVG2.Point<W3C_SVG.Space>
                    if let last = lastControlPoint {
                        let newX = currentPoint.x + (currentPoint.x - last.x)
                        let newY = currentPoint.y + (currentPoint.y - last.y)
                        control = W3C_SVG2.Point<W3C_SVG.Space>(x: newX, y: newY)
                    } else {
                        control = currentPoint
                    }
                    let bezier = W3C_SVG2.Bezier<W3C_SVG.Space>.quadratic(
                        from: currentPoint,
                        control: control,
                        to: end
                    )
                    beziers.append(bezier)
                    lastControlPoint = control
                    currentPoint = end

                case .arc(let arcCmd):
                    let arcBeziers = arcCmd.toBeziers(from: currentPoint)
                    beziers.append(contentsOf: arcBeziers)
                    currentPoint = arcCmd.end
                    lastControlPoint = nil

                case .closePath:
                    if currentPoint != startPoint {
                        beziers.append(.linear(from: currentPoint, to: startPoint))
                    }
                    currentPoint = startPoint
                    lastControlPoint = nil
                }
            }

            return beziers
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
            return "H \(x.formatted(.number))"

        case .verticalLineTo(let y):
            return "V \(y.formatted(.number))"

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
