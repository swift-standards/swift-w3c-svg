//
//  W3C_SVG2.Paths.Path.Serializer.swift
//  swift-w3c-svg
//
//  Serialize Geometry.Path to SVG path data (SVG 2 Section 9)
//

import Formatting
internal import Geometry

extension W3C_SVG2.Paths.Path {
    /// Serializer for converting Geometry.Path to SVG path data strings.
    ///
    /// W3C SVG 2 Section 9.3
    /// https://www.w3.org/TR/SVG2/paths.html#PathData
    ///
    /// ## Example
    ///
    /// ```swift
    /// let d = Path.Serializer.serialize(path)
    /// // Returns: "M 100 100 L 200 100 L 200 200 Z"
    /// ```
    public struct Serializer {
        /// Serialize a Geometry.Path to SVG path data string.
        ///
        /// - Parameter path: The path geometry to serialize
        /// - Returns: SVG path data string (d attribute value)
        public static func serialize(_ path: W3C_SVG2.PathGeometry<W3C_SVG.Space>) -> String {
            var parts: [String] = []

            for subpath in path.subpaths {
                // MoveTo for subpath start
                let startX = subpath.startPoint.x._rawValue.formatted(.number)
                let startY = subpath.startPoint.y._rawValue.formatted(.number)
                parts.append("M \(startX) \(startY)")

                // Serialize each segment
                for segment in subpath.segments {
                    parts.append(serializeSegment(segment))
                }

                // Close path if needed
                if subpath.isClosed {
                    parts.append("Z")
                }
            }

            return parts.joined(separator: " ")
        }

        /// Serialize a single path segment.
        private static func serializeSegment(
            _ segment: W3C_SVG2.PathGeometry<W3C_SVG.Space>.Segment
        ) -> String {
            switch segment {
            case .line(let line):
                let x = line.end.x._rawValue.formatted(.number)
                let y = line.end.y._rawValue.formatted(.number)
                return "L \(x) \(y)"

            case .bezier(let bezier):
                return serializeBezier(bezier)

            case .arc(let arc):
                // Convert arc to beziers for serialization
                // (SVG arcs use endpoint parameterization which is complex to derive)
                let beziers = [W3C_SVG2.Bezier<W3C_SVG.Space>](arc: arc)
                return beziers.map { serializeBezier($0) }.joined(separator: " ")
            }
        }

        /// Serialize a Bezier curve.
        private static func serializeBezier(_ bezier: W3C_SVG2.Bezier<W3C_SVG.Space>) -> String {
            let points = bezier.controlPoints

            switch points.count {
            case 2:
                // Linear (L command)
                let x = points[1].x._rawValue.formatted(.number)
                let y = points[1].y._rawValue.formatted(.number)
                return "L \(x) \(y)"

            case 3:
                // Quadratic (Q command)
                let cx = points[1].x._rawValue.formatted(.number)
                let cy = points[1].y._rawValue.formatted(.number)
                let x = points[2].x._rawValue.formatted(.number)
                let y = points[2].y._rawValue.formatted(.number)
                return "Q \(cx) \(cy) \(x) \(y)"

            case 4:
                // Cubic (C command)
                let c1x = points[1].x._rawValue.formatted(.number)
                let c1y = points[1].y._rawValue.formatted(.number)
                let c2x = points[2].x._rawValue.formatted(.number)
                let c2y = points[2].y._rawValue.formatted(.number)
                let x = points[3].x._rawValue.formatted(.number)
                let y = points[3].y._rawValue.formatted(.number)
                return "C \(c1x) \(c1y) \(c2x) \(c2y) \(x) \(y)"

            default:
                // Higher-order Bezier: approximate with cubics or output as-is
                // For now, just output control points as cubic segments
                return ""
            }
        }
    }
}
