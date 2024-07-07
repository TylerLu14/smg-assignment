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
            line:    CGPoint(x: 0.15 - adjustment, y: 0.00 + adjustment * 2),
            curve:   CGPoint(x: 0.15 + adjustment, y: 0.00),
            control: CGPoint(x: 0.15, y: 0.00)
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
            line:    CGPoint(x: 0.15 + adjustment, y: 1.00),
            curve:   CGPoint(x: 0.15 - adjustment, y: 1.00 - adjustment * 2),
            control: CGPoint(x: 0.15, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.00 + adjustment/2, y: 0.50 + adjustment * 3),
            curve:   startingPoint,
            control: CGPoint(x: 0.00 - adjustment, y: 0.50)
        ),
    ]
}

public struct PriceTagShape: Shape {
    class Constants {
        static let startingPoint = CGPoint(
            x: 0.00,
            y: 0.50
        )
        
        static let adjustment: CGFloat = 2
        
        static let headWidth: CGFloat = 16.0
    }
    
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
                    x: width * Constants.startingPoint.x + Constants.adjustment,
                    y: height * Constants.startingPoint.y - Constants.adjustment * 2
                )
            )
            
            path.addLine(to: CGPoint(
                x: Constants.headWidth - Constants.adjustment,
                y: 0 + Constants.adjustment
            ))
            path.addQuadCurve(
                to: CGPoint(x: Constants.headWidth + Constants.adjustment, y: 0.00),
                control: CGPoint(x: Constants.headWidth, y: 0.00)
            )
            path.addLine(to: CGPoint(
                x: width - Constants.adjustment,
                y: 0
            ))
            path.addQuadCurve(
                to: CGPoint(x: width, y: 0.00 + Constants.adjustment),
                control: CGPoint(x: width, y: 0.00)
            )
            
            path.addLine(to: CGPoint(
                x: width,
                y: height - Constants.adjustment
            ))
            path.addQuadCurve(
                to: CGPoint(x: width - Constants.adjustment, y: height),
                control: CGPoint(x: width, y: height)
            )
            
            path.addLine(to: CGPoint(
                x: Constants.headWidth + Constants.adjustment,
                y: height
            ))
            path.addQuadCurve(
                to: CGPoint(x: Constants.headWidth - Constants.adjustment, y: height - Constants.adjustment ),
                control: CGPoint(x: Constants.headWidth, y: height)
            )
            
            path.addLine(to: CGPoint(
                x: width * Constants.startingPoint.x + Constants.adjustment,
                y: height * Constants.startingPoint.y + Constants.adjustment * 2
            ))
            path.addQuadCurve(
                to: CGPoint(
                    x: width * Constants.startingPoint.x + Constants.adjustment,
                    y: height * Constants.startingPoint.y - Constants.adjustment * 2
                ),
                control: CGPoint(
                    x: width * Constants.startingPoint.x,
                    y: height * Constants.startingPoint.y
                )
            )
            
            path.closeSubpath()

            path.addArc(
                center: CGPoint(x: width - 8.0, y: height - 8.0),
                radius: rect.height / 9,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: true
            )
        }
    }
}

#Preview {
    ZStack {
        PriceTagShape()
            .stroke(.red)
    }
    .padding()
    .frame(width: 320, height: 80)
}
