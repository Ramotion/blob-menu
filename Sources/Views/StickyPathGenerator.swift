//
//  StickyPathGenerator.swift
//  BlobMenu
//
//  Created by Igor K. on 29.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

public final class StickyPathGenerator {
    
    static let `default` = StickyPathGenerator()
    
    private enum Direction {
        case up
        case left
        case right
        case down
    }
    
    private struct Input {
        let baseRect: CGRect
        let figureRect: CGRect
        let figureCornerRadius: CGFloat
        let avulsionDistance: CGFloat
        
        /// Calculated constants
        let figurePointA: CGPoint
        let figurePointB: CGPoint
        let basePointA: CGPoint
        let basePointB: CGPoint
        let initialBasePointA: CGPoint
        let initialBasePointB: CGPoint
        
        /// Distance between figure and base
        let distance: CGFloat
        
        init(baseRect: CGRect,
             figureRect: CGRect,
             figureCornerRadius: CGFloat,
             avulsionDistance: CGFloat) {
            
           
            self.baseRect = baseRect
            self.figureRect = figureRect
            self.figureCornerRadius = figureCornerRadius
            self.avulsionDistance = avulsionDistance
            
            figurePointA = CGPoint(x: figureRect.maxX, y: figureRect.minY)
            figurePointB = CGPoint(x: figureRect.maxX, y: figureRect.maxY)
            basePointA = CGPoint(x: baseRect.minX, y: max(baseRect.minY, figureRect.minY))
            basePointB = CGPoint(x: baseRect.minX, y: min(baseRect.maxY, figureRect.maxY))
            initialBasePointA = basePointA
            initialBasePointB = basePointB
            distance = baseRect.minX - figureRect.maxX
        }
    }
    
    ///Bool flag to control shape constriction
    private var stopConstriction: Bool = false

    private var apexControlUp: CGPoint = CGPoint.zero
    private var apexControlDown: CGPoint = CGPoint.zero
    
    private var storedBasePointA: CGPoint?
    private var storedBasePointB: CGPoint?
    
    public func generatePath(baseRect: CGRect,
                             figureRect: CGRect,
                             figureCornerRadius: CGFloat,
                             avulsionDistance: CGFloat) -> CGPath {
        
        let input = Input(baseRect: baseRect, figureRect: figureRect, figureCornerRadius: figureCornerRadius, avulsionDistance: avulsionDistance)
        
        return generateShapePath(input: input).cgPath
    }
    
    
    /// Calculate Base Line Points for shape
    /// - used movement on Xaxis
    /// - return (point0, point3)
    private func calculateBaseLinePoints(input: Input) -> (CGPoint, CGPoint) {
        let distance = max(0, input.distance)
        let pY = { (from: CGFloat, to: CGFloat, lineSegment: CGFloat) -> CGFloat in
            //calculate movement coeficient from start to finish while distance <= avulsion
            let coef = abs(to - from) / lineSegment
            let p = from < to ? from + coef * distance : from - coef * distance
            return p
        }
        
        let movement = (input.figurePointA.y - input.initialBasePointA.y)
        let cornerRadius = input.figureCornerRadius
        
        //point0
        let startY0 = max(input.baseRect.minY, input.initialBasePointA.y - cornerRadius + movement)
        let finishY0 = max(input.baseRect.minY, input.initialBasePointA.y + cornerRadius + movement)
        let point0 = CGPoint(x: input.initialBasePointA.x,
                             y: pY(startY0, finishY0, input.avulsionDistance))
        
        //point3
        let startY3 = min(input.baseRect.maxY, input.initialBasePointB.y + cornerRadius + movement)
        let finishY3 = min(input.baseRect.maxY, input.initialBasePointB.y - cornerRadius + movement)
        let point3 = CGPoint(x: input.initialBasePointB.x,
                             y: pY(startY3, finishY3, input.avulsionDistance))
        
        //set limit for movement
        let limitDistanceBetwenPoints = input.figureRect.height - cornerRadius * 2
        if stopConstriction || point3.y - point0.y < limitDistanceBetwenPoints,
           let pA = storedBasePointA, let pB = storedBasePointB {
            //in that case use stored values
            return (pA, pB)
        }
        
        return (point0, point3)
    }
    
    /// Calculate points of intercsection betwen two circles
    /// The solution is to find tangents by calculation of intersection of two circles
    /// https://www.mathsisfun.com/geometry/construct-circletangent.html
    /// Intersection of two circles
    /// Discussion http://stackoverflow.com/questions/3349125/circle-circle-intersection-points
    /// Description http://paulbourke.net/geometry/circlesphere/
    
    private func findIntersection(centerCircle1 c1: CGPoint, radiusCircle1 c1r: CGFloat, centerCircle2 c2: CGPoint) -> (CGPoint, CGPoint) {
        
        //Calculate distance between centres of circle
        let d = (c1 - c2).length
        let c2r = d //in our case
        let m = c1r + c2r
        var n = c1r - c2r
        
        if (n < 0) {
            n = n * -1
        }
        
        //No solns
        if (d > m) {
            return (CGPoint.zero, CGPoint.zero)
        }
        //Circle are contained within each other
        if (d < n) {
            return (CGPoint.zero, CGPoint.zero)
        }
        //Circles are the same
        if (d == 0 && c1r == c2r) {
            return (CGPoint.zero, CGPoint.zero)
        }
        
        let a = (c1r * c1r - c2r * c2r + d * d) / (2 * d)
        
        let h = sqrt(c1r * c1r - a * a)
        
        //Calculate point p, where the line through the circle intersection points crosses the line between the circle centers.
        
        var x = c1.x + (a / d) * (c2.x - c1.x)
        var y = c1.y + (a / d) * (c2.y - c1.y)
        let p = CGPoint(x: x, y: y)
        
        //1 Intersection , circles are touching
        if (d == c1r + c2r) {
            return (p, CGPoint.zero)
        }
        
        //2 Intersections
        //Intersection 1
        x = p.x + (h / d) * (c2.y - c1.y)
        y = p.y - (h / d) * (c2.x - c1.x)
        let p1 = CGPoint(x: x, y: y)
        
        //Intersection 2
        x = p.x - (h / d) * (c2.y - c1.y)
        y = p.y + (h / d) * (c2.x - c1.x)
        let p2 = CGPoint(x: x, y: y)
        
        return (p1, p2)
    }
    
    
    /// Calculate left top point of shape
    /// - used method of intersection betwen two circles
    /// - first circle - centerfigCircle
    /// - second circle - circle from controlPoint
    private func calculateShapePoint1(input: Input, cp:CGPoint, point0:CGPoint) -> CGPoint {
        let cornerRadius = input.figureCornerRadius
        var centerfigCircle = CGPoint(x: input.figurePointA.x - cornerRadius,
                                      y: input.figurePointA.y + cornerRadius)
        centerfigCircle.x = point0.x - centerfigCircle.x < cornerRadius ? point0.x - cornerRadius : centerfigCircle.x
        centerfigCircle.x = max(centerfigCircle.x, input.figurePointA.x + cornerRadius - input.figureRect.width)
        let x3 = (centerfigCircle.x + cp.x) / 2
        let y3 = (centerfigCircle.y + cp.y) / 2
        let c1 = centerfigCircle
        let c2 = CGPoint(x: x3, y: y3)
        let c1r = cornerRadius
        var (p1, _) = findIntersection(centerCircle1: c1, radiusCircle1: c1r, centerCircle2: c2)
        
        //when something wrong in findIntersection pass top center point
        if p1 == CGPoint.zero {
            p1 = CGPoint(x: centerfigCircle.x, y: centerfigCircle.y - cornerRadius)
        }
        
        return p1
    }
    
    /// Calculate left bottom point of shape
    /// - used method of intersection betwen two circles
    /// - first circle - centerfigCircle
    /// - second circle - circle from controlPoint
    private func calculateShapePoint2(input: Input, cp:CGPoint, point3:CGPoint) -> CGPoint {
        let cornerRadius = input.figureCornerRadius
        var circleCenter = CGPoint(x: input.figurePointB.x - cornerRadius,
                                   y: input.figurePointB.y - cornerRadius)
        circleCenter.x = point3.x - circleCenter.x < cornerRadius ? point3.x - cornerRadius : circleCenter.x
        circleCenter.x = max(circleCenter.x, input.figurePointA.x + cornerRadius - input.figureRect.width)
        let x3 = (circleCenter.x + cp.x) / 2
        let y3 = (circleCenter.y + cp.y) / 2
        let c1 = circleCenter
        let c2 = CGPoint(x: x3, y: y3)
        let c1r = cornerRadius
        var (_, p2) = findIntersection(centerCircle1: c1, radiusCircle1: c1r, centerCircle2: c2)
        
        if p2 == CGPoint.zero {
            p2 = CGPoint(x: circleCenter.x, y: circleCenter.y - cornerRadius)
        }
        
        return p2
    }
    

    /// Calculate 2 control points for Bezier Path
    /// - concavity depends of distance
    /// - used movement for concavity effect
    private func calculateControlPoints(input: Input, basePoint: CGPoint, direction: Direction) -> (CGPoint, CGPoint) {
        
        let k: CGFloat = (input.figureRect.width > input.figureRect.height) ? 1.05 : 1.3
        var y: CGFloat = 0
        
        if direction == .down {
            let controlPointСoncavity = input.distance + input.distance * 0.05
            let deltaY = abs(basePoint.y - input.figurePointA.y) / k
            y = basePoint.y + controlPointСoncavity
            y = max(basePoint.y + deltaY, y)
            
        } else if direction == .up {
            let controlPointСoncavity = max(0, input.distance + input.distance * 0.05)
            let deltaY = abs(basePoint.y - input.figurePointB.y) / k
            y = basePoint.y - controlPointСoncavity
            y = min(basePoint.y - deltaY, y)
        }
        
        let cp1 = CGPoint(x: basePoint.x, y: y)
        let cp2 = CGPoint(x: min(basePoint.x, input.figurePointA.x + input.distance / 4), y: cp1.y)
        
        return (cp1, cp2)
    }
    
    //MARK: - Generate main path
    /*
     vertical scheme:
     point1  |------------------------------| point2
             |                              |
             | -cpUp2              cpDown2- |
             |                              |
             | -cpUp1              cpDown1- |
     point0  |______________________________| point3
     
     
     horizontal scheme:
     point1  _____________________  point0
            | cpTop2      cpTop1  |
            |                     |
            |                     |
            |                     |
            | cpBottom2 cpBottom1 |
     point2 |_____________________| point3
     
     */
    
    /// Generate shape path
    /// - calculate baseLinePoints (point0, point3)
    /// - calculate control points
    /// - calculate topLinePoints (point1, point2)
    /// - constrinction control
    /// - draw the shape by points
    private func generateShapePath(input: Input) -> UIBezierPath {
        let distance = max(0, input.distance)
        
        //calculate base points
        let (point0, point3) = calculateBaseLinePoints(input: input)
        
        //calculete control points
        var (cpUp1, cpUp2)  =  calculateControlPoints(input: input, basePoint: point0, direction: .down)
        var (cpDown1, cpDown2) = calculateControlPoints(input: input, basePoint: point3, direction: .up)
        var point1 = calculateShapePoint1(input: input, cp: cpUp2, point0: point0)
        var point2 = calculateShapePoint2(input: input, cp: cpDown2, point3: point3)
        
        //constriction control
        let upPoints =  BezierUtilities.getCubeCurvePoints(p0: point0, p1: cpUp1, p2: cpUp2, p3: point1)
        let downPoints = BezierUtilities.getCubeCurvePoints(p0: point2, p1: cpDown2, p2: cpDown1, p3: point3)
        
        //search for curve cross
        var crossed = false
        for up in upPoints {
            for dp in downPoints {
                let delta = dp.y - up.y
                if delta <= 1 {
                    crossed = true
                    break
                }
            }
        }
        
        self.stopConstriction = crossed
        
        //if true - we'll use old values
        if crossed {
            cpUp2.y = apexControlUp.y
            cpUp1.y = apexControlUp.y
            
            cpDown2.y = apexControlDown.y
            cpDown1.y = apexControlDown.y
            
            point1 = calculateShapePoint1(input: input, cp: cpUp2, point0: point0)
            point2 = calculateShapePoint2(input: input, cp: cpDown2, point3: point3)
        } else {
            storedBasePointA = point0
            storedBasePointB = point3
            apexControlUp = cpUp2
            apexControlDown = cpDown2
        }
        
    
        //Do not need to draw shape under baseLine or after avulsion
        if distance <= -input.figureRect.width || distance > input.avulsionDistance {
            stopConstriction = false
            
            point1 = CGPoint(x: point0.x, y: point0.y)
            point2 = CGPoint(x: point0.x, y: point0.y + input.figureRect.height)
            cpUp1 = point0
            cpUp2 = point0
            cpDown1 = point3
            cpDown2 = point3
        }
        
        let curvePath = UIBezierPath()
        curvePath.move(to: point0)
        curvePath.addCurve(to: point1, controlPoint1: cpUp1, controlPoint2: cpUp2)
        if crossed {
            curvePath.addLine(to: point2)
        } else {
            let center = input.figureRect.center
            let dc = CGPoint(x: center.x - 0.5, y: center.y) // to fix small gap between menu and arc
            let start = atan((point1.y - center.y) / (point1.x - center.x))
            let end = atan((point2.y - center.y) / (point2.x - center.x))
            curvePath.addArc(withCenter: dc, radius: input.figureCornerRadius, startAngle: start, endAngle: end, clockwise: true)
            curvePath.addLine(to: point2)
        }
        curvePath.addCurve(to: point3, controlPoint1: cpDown2, controlPoint2: cpDown1)
        
        return curvePath
    }
}

