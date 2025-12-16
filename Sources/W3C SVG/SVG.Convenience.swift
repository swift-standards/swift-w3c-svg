//
//  SVG.Convenience.swift
//  swift-w3c-svg
//
//  Convenience extensions for creating styled geometry.
//

// MARK: - Circle Convenience

extension SVG.Circle {
    /// Create a styled circle with a fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> SVG.Styled.Circle {
        SVG.Styled.Circle(geometry: self, fill: color)
    }

    /// Create a styled circle with a stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> SVG.Styled.Circle {
        SVG.Styled.Circle(geometry: self, stroke: stroke)
    }

    /// Create a styled circle with a stroke color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> SVG.Styled.Circle {
        SVG.Styled.Circle(geometry: self, stroke: .init(color: color, width: width))
    }
}

// MARK: - Rectangle Convenience

extension SVG.Rectangle {
    /// Create a styled rectangle with a fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> SVG.Styled.Rectangle {
        SVG.Styled.Rectangle(geometry: self, fill: color)
    }

    /// Create a styled rectangle with a stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> SVG.Styled.Rectangle {
        SVG.Styled.Rectangle(geometry: self, stroke: stroke)
    }

    /// Create a styled rectangle with a stroke color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> SVG.Styled.Rectangle {
        SVG.Styled.Rectangle(geometry: self, stroke: .init(color: color, width: width))
    }
}

// MARK: - Ellipse Convenience

extension SVG.Ellipse {
    /// Create a styled ellipse with a fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> SVG.Styled.Ellipse {
        SVG.Styled.Ellipse(geometry: self, fill: color)
    }

    /// Create a styled ellipse with a stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> SVG.Styled.Ellipse {
        SVG.Styled.Ellipse(geometry: self, stroke: stroke)
    }

    /// Create a styled ellipse with a stroke color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> SVG.Styled.Ellipse {
        SVG.Styled.Ellipse(geometry: self, stroke: .init(color: color, width: width))
    }
}

// MARK: - Line Convenience

extension SVG.Line {
    /// Create a styled line with a stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> SVG.Styled.Line {
        SVG.Styled.Line(geometry: self, stroke: stroke)
    }

    /// Create a styled line with a stroke color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> SVG.Styled.Line {
        SVG.Styled.Line(geometry: self, stroke: .init(color: color, width: width))
    }
}

// MARK: - Polygon Convenience

extension SVG.Polygon {
    /// Create a styled polygon with a fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> SVG.Styled.Polygon {
        SVG.Styled.Polygon(geometry: self, fill: color)
    }

    /// Create a styled polygon with a stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> SVG.Styled.Polygon {
        SVG.Styled.Polygon(geometry: self, stroke: stroke)
    }

    /// Create a styled polygon with a stroke color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> SVG.Styled.Polygon {
        SVG.Styled.Polygon(geometry: self, stroke: .init(color: color, width: width))
    }
}

// MARK: - Path Convenience

extension SVG.Path {
    /// Create a styled path with a fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> SVG.Styled.Path {
        SVG.Styled.Path(geometry: self, fill: color)
    }

    /// Create a styled path with a stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> SVG.Styled.Path {
        SVG.Styled.Path(geometry: self, stroke: stroke)
    }

    /// Create a styled path with a stroke color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> SVG.Styled.Path {
        SVG.Styled.Path(geometry: self, stroke: .init(color: color, width: width))
    }
}

// MARK: - Styled Circle Chaining

extension SVG.Styled.Circle {
    /// Add or update the fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> Self {
        var copy = self
        copy.fill = color
        return copy
    }

    /// Add or update the stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> Self {
        var copy = self
        copy.stroke = stroke
        return copy
    }

    /// Add or update the stroke with a color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> Self {
        var copy = self
        copy.stroke = .init(color: color, width: width)
        return copy
    }
}

// MARK: - Styled Rectangle Chaining

extension SVG.Styled.Rectangle {
    /// Add or update the fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> Self {
        var copy = self
        copy.fill = color
        return copy
    }

    /// Add or update the stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> Self {
        var copy = self
        copy.stroke = stroke
        return copy
    }

    /// Add or update the stroke with a color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> Self {
        var copy = self
        copy.stroke = .init(color: color, width: width)
        return copy
    }

    /// Set corner radii for rounded rectangles.
    public func rounded(rx: SVG.Width? = nil, ry: SVG.Height? = nil) -> Self {
        var copy = self
        copy.rx = rx
        copy.ry = ry
        return copy
    }
}

// MARK: - Styled Ellipse Chaining

extension SVG.Styled.Ellipse {
    /// Add or update the fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> Self {
        var copy = self
        copy.fill = color
        return copy
    }

    /// Add or update the stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> Self {
        var copy = self
        copy.stroke = stroke
        return copy
    }

    /// Add or update the stroke with a color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> Self {
        var copy = self
        copy.stroke = .init(color: color, width: width)
        return copy
    }
}

// MARK: - Styled Line Chaining

extension SVG.Styled.Line {
    /// Add or update the stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> Self {
        var copy = self
        copy.stroke = stroke
        return copy
    }

    /// Add or update the stroke with a color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> Self {
        var copy = self
        copy.stroke = .init(color: color, width: width)
        return copy
    }
}

// MARK: - Styled Polygon Chaining

extension SVG.Styled.Polygon {
    /// Add or update the fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> Self {
        var copy = self
        copy.fill = color
        return copy
    }

    /// Add or update the stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> Self {
        var copy = self
        copy.stroke = stroke
        return copy
    }

    /// Add or update the stroke with a color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> Self {
        var copy = self
        copy.stroke = .init(color: color, width: width)
        return copy
    }
}

// MARK: - Styled Path Chaining

extension SVG.Styled.Path {
    /// Add or update the fill color.
    public func filled(_ color: W3C_SVG2.Types.Color) -> Self {
        var copy = self
        copy.fill = color
        return copy
    }

    /// Add or update the stroke.
    public func stroked(_ stroke: SVG.Styled.Stroke) -> Self {
        var copy = self
        copy.stroke = stroke
        return copy
    }

    /// Add or update the stroke with a color.
    public func stroked(_ color: W3C_SVG2.Types.Color, width: SVG.Width? = nil) -> Self {
        var copy = self
        copy.stroke = .init(color: color, width: width)
        return copy
    }

    /// Set the fill rule.
    public func fillRule(_ rule: W3C_SVG2.Painting.FillRule) -> Self {
        var copy = self
        copy.fillRule = rule
        return copy
    }
}
