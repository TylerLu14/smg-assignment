//
//  PriceTagShape.swift
//  SMGAssignment
//
//  Created by Lữ on 7/7/24.
//

import SwiftUI

struct PriceTagShapeParameters {
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }
    
    
    static let adjustment: CGFloat = 0.05
    
    static let startingPoint = CGPoint(
        x: 0.00 + adjustment/2,
        y: 0.50 - adjustment * 3
    )
    
    
    static let segments = [
        Segment(
            line:    CGPoint(x: 0.20 - adjustment, y: 0.00 + adjustment * 2),
            curve:   CGPoint(x: 0.20 + adjustment, y: 0.00),
            control: CGPoint(x: 0.20, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 1.00 - adjustment, y: 0.00),
            curve:   CGPoint(x: 1.00, y: 0.00 + adjustment * 2),
            control: CGPoint(x: 1.00, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 1.00, y: 1.00 - adjustment * 2),
            curve:   CGPoint(x: 1.00 - adjustment, y: 1.00),
            control: CGPoint(x: 1.00, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.20 + adjustment, y: 1.00),
            curve:   CGPoint(x: 0.20 - adjustment, y: 1.00 - adjustment * 2),
            control: CGPoint(x: 0.20, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.00 + adjustment/2, y: 0.50 + adjustment * 3),
            curve:   startingPoint,
            control: CGPoint(x: 0.00 - adjustment, y: 0.50)
        ),
    ]
}

public struct PriceTagShape: Shape {
    /// Creates a square bottomed pentagon.
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        print(width)
        print(height)

        return Path { path in
            path.move(
                to: CGPoint(
                    x: width * PriceTagShapeParameters.startingPoint.x,
                    y: height * PriceTagShapeParameters.startingPoint.y
                )
            )
            
            PriceTagShapeParameters.segments.forEach { segment in
                path.addLine(
                    to: CGPoint(
                        x: width * segment.line.x,
                        y: height * segment.line.y
                    )
                )
                
                path.addQuadCurve(
                    to: CGPoint(
                        x: width * segment.curve.x,
                        y: height * segment.curve.y
                    ),
                    control: CGPoint(
                        x: width * segment.control.x,
                        y: height * segment.control.y
                    )
                )
            }
            
            path.closeSubpath()
            
            path.addArc(
                center: CGPoint(x: width * 0.93, y: height * 0.80),
                radius: rect.height/9,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: true
            )

        }
    }
}

#Preview {
    GeometryReader { geo in
        PriceTagShape()
            .stroke(.red)
    }
    .padding()
    .frame(height: 200)
}
