//
//  SVG.Styled.swift
//  swift-w3c-svg
//
//  Geometry types combined with SVG styling (fill, stroke).
//

// MARK: - Styled Namespace

extension SVG {
    /// Styled geometry types that combine shape with fill and stroke properties.
    public enum Styled {}
}

// MARK: - Stroke Configuration

extension SVG.Styled {
    /// Stroke configuration for SVG shapes.
    public struct Stroke: Sendable, Hashable {
        /// The stroke color.
        public var color: W3C_SVG2.Types.Color

        /// The stroke width.
        public var width: SVG.Width?

        /// The line cap style.
        public var lineCap: W3C_SVG2.Painting.LineCap?

        /// The line join style.
        public var lineJoin: W3C_SVG2.Painting.LineJoin?

        /// Creates a stroke configuration.
        public init(
            color: W3C_SVG2.Types.Color,
            width: SVG.Width? = nil,
            lineCap: W3C_SVG2.Painting.LineCap? = nil,
            lineJoin: W3C_SVG2.Painting.LineJoin? = nil
        ) {
            self.color = color
            self.width = width
            self.lineCap = lineCap
            self.lineJoin = lineJoin
        }
    }
}

// MARK: - Styled Circle

extension SVG.Styled {
    /// A circle with fill and stroke styling.
    public struct Circle: Sendable, Hashable {
        /// The circle geometry.
        public var geometry: SVG.Circle

        /// The fill color.
        public var fill: W3C_SVG2.Types.Color?

        /// The stroke configuration.
        public var stroke: Stroke?

        /// Creates a styled circle.
        public init(
            geometry: SVG.Circle,
            fill: W3C_SVG2.Types.Color? = nil,
            stroke: Stroke? = nil
        ) {
            self.geometry = geometry
            self.fill = fill
            self.stroke = stroke
        }
    }
}

// MARK: - Styled Rectangle

extension SVG.Styled {
    /// A rectangle with fill and stroke styling.
    public struct Rectangle: Sendable, Hashable {
        /// The rectangle geometry.
        public var geometry: SVG.Rectangle

        /// The fill color.
        public var fill: W3C_SVG2.Types.Color?

        /// The stroke configuration.
        public var stroke: Stroke?

        /// Corner radius for x-axis (optional).
        public var rx: SVG.Width?

        /// Corner radius for y-axis (optional).
        public var ry: SVG.Height?

        /// Creates a styled rectangle.
        public init(
            geometry: SVG.Rectangle,
            fill: W3C_SVG2.Types.Color? = nil,
            stroke: Stroke? = nil,
            rx: SVG.Width? = nil,
            ry: SVG.Height? = nil
        ) {
            self.geometry = geometry
            self.fill = fill
            self.stroke = stroke
            self.rx = rx
            self.ry = ry
        }
    }
}

// MARK: - Styled Ellipse

extension SVG.Styled {
    /// An ellipse with fill and stroke styling.
    public struct Ellipse: Sendable, Hashable {
        /// The ellipse geometry.
        public var geometry: SVG.Ellipse

        /// The fill color.
        public var fill: W3C_SVG2.Types.Color?

        /// The stroke configuration.
        public var stroke: Stroke?

        /// Creates a styled ellipse.
        public init(
            geometry: SVG.Ellipse,
            fill: W3C_SVG2.Types.Color? = nil,
            stroke: Stroke? = nil
        ) {
            self.geometry = geometry
            self.fill = fill
            self.stroke = stroke
        }
    }
}

// MARK: - Styled Line

extension SVG.Styled {
    /// A line with stroke styling.
    public struct Line: Sendable, Hashable {
        /// The line geometry.
        public var geometry: SVG.Line

        /// The stroke configuration.
        public var stroke: Stroke?

        /// Creates a styled line.
        public init(
            geometry: SVG.Line,
            stroke: Stroke? = nil
        ) {
            self.geometry = geometry
            self.stroke = stroke
        }
    }
}

// MARK: - Styled Polygon

extension SVG.Styled {
    /// A polygon with fill and stroke styling.
    public struct Polygon: Sendable, Hashable {
        /// The polygon geometry.
        public var geometry: SVG.Polygon

        /// The fill color.
        public var fill: W3C_SVG2.Types.Color?

        /// The stroke configuration.
        public var stroke: Stroke?

        /// Creates a styled polygon.
        public init(
            geometry: SVG.Polygon,
            fill: W3C_SVG2.Types.Color? = nil,
            stroke: Stroke? = nil
        ) {
            self.geometry = geometry
            self.fill = fill
            self.stroke = stroke
        }
    }
}

// MARK: - Styled Path

extension SVG.Styled {
    /// A path with fill and stroke styling.
    public struct Path: Sendable, Hashable {
        /// The path geometry.
        public var geometry: SVG.Path

        /// The fill color.
        public var fill: W3C_SVG2.Types.Color?

        /// The fill rule.
        public var fillRule: W3C_SVG2.Painting.FillRule?

        /// The stroke configuration.
        public var stroke: Stroke?

        /// Creates a styled path.
        public init(
            geometry: SVG.Path,
            fill: W3C_SVG2.Types.Color? = nil,
            fillRule: W3C_SVG2.Painting.FillRule? = nil,
            stroke: Stroke? = nil
        ) {
            self.geometry = geometry
            self.fill = fill
            self.fillRule = fillRule
            self.stroke = stroke
        }
    }
}
