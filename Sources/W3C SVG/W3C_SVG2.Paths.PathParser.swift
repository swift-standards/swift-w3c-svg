//
//  W3C_SVG2.Paths.PathParser.swift
//  swift-w3c-svg
//
//  SVG path data parser (SVG 2 Section 9)
//

import Foundation
internal import Geometry

extension W3C_SVG2.Paths {
    /// Parser for SVG path data strings.
    ///
    /// W3C SVG 2 Section 9.3
    /// https://www.w3.org/TR/SVG2/paths.html#PathData
    ///
    /// Parses SVG path data (the 'd' attribute) into a sequence of `PathCommand` values.
    ///
    /// ## Supported Commands
    ///
    /// - M/m: moveto
    /// - L/l: lineto
    /// - H/h: horizontal lineto
    /// - V/v: vertical lineto
    /// - C/c: cubic Bezier curve
    /// - S/s: smooth cubic Bezier curve
    /// - Q/q: quadratic Bezier curve
    /// - T/t: smooth quadratic Bezier curve
    /// - A/a: elliptical arc
    /// - Z/z: closepath
    ///
    /// ## Example
    ///
    /// ```swift
    /// let commands = PathParser.parse("M 100 100 L 200 100 L 200 200 Z")
    /// // Returns: [.moveTo(...), .lineTo(...), .lineTo(...), .closePath]
    /// ```
    public struct PathParser {
        /// Parse an SVG path data string into commands.
        ///
        /// - Parameter pathData: The path data string (d attribute value)
        /// - Returns: Array of parsed path commands
        public static func parse(_ pathData: String) -> [PathCommand] {
            var parser = PathParser(pathData)
            return parser.parseCommands()
        }

        private var input: String
        private var index: String.Index
        private var currentPoint: W3C_SVG2.Point<W3C_SVG.Space> = .init(x: .init(0), y: .init(0))
        private var startPoint: W3C_SVG2.Point<W3C_SVG.Space> = .init(x: .init(0), y: .init(0))
        private var lastControlPoint: W3C_SVG2.Point<W3C_SVG.Space>?

        private init(_ input: String) {
            self.input = input
            self.index = input.startIndex
        }

        private mutating func parseCommands() -> [PathCommand] {
            var commands: [PathCommand] = []

            while index < input.endIndex {
                skipWhitespaceAndCommas()
                guard index < input.endIndex else { break }

                let command = input[index]
                guard command.isLetter else { break }
                index = input.index(after: index)

                let isRelative = command.isLowercase
                let cmd = command.uppercased().first!

                switch cmd {
                case "M":
                    parseMoveTo(isRelative: isRelative, commands: &commands)
                case "L":
                    parseLineTo(isRelative: isRelative, commands: &commands)
                case "H":
                    parseHorizontalLineTo(isRelative: isRelative, commands: &commands)
                case "V":
                    parseVerticalLineTo(isRelative: isRelative, commands: &commands)
                case "C":
                    parseCubicBezier(isRelative: isRelative, commands: &commands)
                case "S":
                    parseSmoothCubicBezier(isRelative: isRelative, commands: &commands)
                case "Q":
                    parseQuadraticBezier(isRelative: isRelative, commands: &commands)
                case "T":
                    parseSmoothQuadraticBezier(isRelative: isRelative, commands: &commands)
                case "A":
                    parseArc(isRelative: isRelative, commands: &commands)
                case "Z":
                    commands.append(.closePath)
                    currentPoint = startPoint
                    lastControlPoint = nil
                default:
                    break
                }
            }

            return commands
        }

        // MARK: - Command Parsers

        private mutating func parseMoveTo(isRelative: Bool, commands: inout [PathCommand]) {
            var isFirst = true
            while let point = parsePoint(isRelative: isRelative) {
                if isFirst {
                    commands.append(.moveTo(point))
                    startPoint = point
                    isFirst = false
                } else {
                    // Subsequent coordinates are implicit lineto
                    commands.append(.lineTo(point))
                }
                currentPoint = point
                lastControlPoint = nil
            }
        }

        private mutating func parseLineTo(isRelative: Bool, commands: inout [PathCommand]) {
            while let point = parsePoint(isRelative: isRelative) {
                commands.append(.lineTo(point))
                currentPoint = point
                lastControlPoint = nil
            }
        }

        private mutating func parseHorizontalLineTo(isRelative: Bool, commands: inout [PathCommand]) {
            while let x = parseNumber() {
                let newX: W3C_SVG2.SVGSpace.X = isRelative
                    ? currentPoint.x + W3C_SVG2.SVGSpace.Dx(x)
                    : W3C_SVG2.SVGSpace.X(x)
                commands.append(.horizontalLineTo(x: newX._rawValue))
                currentPoint = W3C_SVG2.Point<W3C_SVG.Space>(x: newX, y: currentPoint.y)
                lastControlPoint = nil
            }
        }

        private mutating func parseVerticalLineTo(isRelative: Bool, commands: inout [PathCommand]) {
            while let y = parseNumber() {
                let newY: W3C_SVG2.SVGSpace.Y = isRelative
                    ? currentPoint.y + W3C_SVG2.SVGSpace.Dy(y)
                    : W3C_SVG2.SVGSpace.Y(y)
                commands.append(.verticalLineTo(y: newY._rawValue))
                currentPoint = W3C_SVG2.Point<W3C_SVG.Space>(x: currentPoint.x, y: newY)
                lastControlPoint = nil
            }
        }

        private mutating func parseCubicBezier(isRelative: Bool, commands: inout [PathCommand]) {
            while let control1 = parsePoint(isRelative: isRelative),
                let control2 = parsePoint(isRelative: isRelative),
                let end = parsePoint(isRelative: isRelative)
            {
                let bezier = W3C_SVG2.Bezier<W3C_SVG.Space>.cubic(
                    from: currentPoint,
                    control1: control1,
                    control2: control2,
                    to: end
                )
                commands.append(.cubicBezier(bezier))
                lastControlPoint = control2
                currentPoint = end
            }
        }

        private mutating func parseSmoothCubicBezier(
            isRelative: Bool,
            commands: inout [PathCommand]
        ) {
            while let control2 = parsePoint(isRelative: isRelative),
                let end = parsePoint(isRelative: isRelative)
            {
                commands.append(.smoothCubicBezier(control2: control2, end: end))
                lastControlPoint = control2
                currentPoint = end
            }
        }

        private mutating func parseQuadraticBezier(isRelative: Bool, commands: inout [PathCommand]) {
            while let control = parsePoint(isRelative: isRelative),
                let end = parsePoint(isRelative: isRelative)
            {
                commands.append(.quadraticBezier(control: control, end: end))
                lastControlPoint = control
                currentPoint = end
            }
        }

        private mutating func parseSmoothQuadraticBezier(
            isRelative: Bool,
            commands: inout [PathCommand]
        ) {
            while let end = parsePoint(isRelative: isRelative) {
                commands.append(.smoothQuadraticBezier(end: end))
                // For smooth quadratic, control is reflection of last control
                // Reflection formula: new = current + (current - last)
                if let last = lastControlPoint {
                    let newX = currentPoint.x + (currentPoint.x - last.x)
                    let newY = currentPoint.y + (currentPoint.y - last.y)
                    lastControlPoint = W3C_SVG2.Point<W3C_SVG.Space>(x: newX, y: newY)
                } else {
                    lastControlPoint = currentPoint
                }
                currentPoint = end
            }
        }

        private mutating func parseArc(isRelative: Bool, commands: inout [PathCommand]) {
            while let rx = parseNumber(),
                let ry = parseNumber(),
                let rotation = parseNumber(),
                let largeArc = parseFlag(),
                let sweep = parseFlag(),
                let end = parsePoint(isRelative: isRelative)
            {
                let arcCmd = ArcCommand(
                    rx: rx,
                    ry: ry,
                    xAxisRotation: rotation,
                    largeArcFlag: largeArc,
                    sweepFlag: sweep,
                    end: end
                )
                commands.append(.arc(arcCmd))
                currentPoint = end
                lastControlPoint = nil
            }
        }

        // MARK: - Primitive Parsers

        private mutating func parsePoint(isRelative: Bool) -> W3C_SVG2.Point<W3C_SVG.Space>? {
            skipWhitespaceAndCommas()
            guard let x = parseNumber(), let y = parseNumber() else { return nil }
            if isRelative {
                // Add displacement to current point
                let displacement = W3C_SVG2.Vector<W3C_SVG.Space>(
                    dx: W3C_SVG2.SVGSpace.Dx(x),
                    dy: W3C_SVG2.SVGSpace.Dy(y)
                )
                return currentPoint + displacement
            } else {
                return W3C_SVG2.Point<W3C_SVG.Space>(
                    x: W3C_SVG2.SVGSpace.X(x),
                    y: W3C_SVG2.SVGSpace.Y(y)
                )
            }
        }

        private mutating func parseNumber() -> Double? {
            skipWhitespaceAndCommas()
            guard index < input.endIndex else { return nil }

            let startIdx = index

            // Optional sign
            if index < input.endIndex && (input[index] == "-" || input[index] == "+") {
                index = input.index(after: index)
            }

            // Digits before decimal
            while index < input.endIndex && input[index].isNumber {
                index = input.index(after: index)
            }

            // Decimal point
            if index < input.endIndex && input[index] == "." {
                index = input.index(after: index)
                // Digits after decimal
                while index < input.endIndex && input[index].isNumber {
                    index = input.index(after: index)
                }
            }

            // Exponent
            if index < input.endIndex && (input[index] == "e" || input[index] == "E") {
                index = input.index(after: index)
                // Exponent sign
                if index < input.endIndex && (input[index] == "-" || input[index] == "+") {
                    index = input.index(after: index)
                }
                // Exponent digits
                while index < input.endIndex && input[index].isNumber {
                    index = input.index(after: index)
                }
            }

            guard index > startIdx else { return nil }
            let numberStr = String(input[startIdx..<index])
            return Double(numberStr)
        }

        private mutating func parseFlag() -> Bool? {
            skipWhitespaceAndCommas()
            guard index < input.endIndex else { return nil }
            let char = input[index]
            if char == "0" {
                index = input.index(after: index)
                return false
            } else if char == "1" {
                index = input.index(after: index)
                return true
            }
            return nil
        }

        private mutating func skipWhitespaceAndCommas() {
            while index < input.endIndex {
                let char = input[index]
                if char == " " || char == "\t" || char == "\n" || char == "\r" || char == "," {
                    index = input.index(after: index)
                } else {
                    break
                }
            }
        }
    }
}
