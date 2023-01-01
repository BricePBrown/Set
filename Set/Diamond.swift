//
//  SetShapes.swift
//  Set
//
//  Created by Brice Brown on 12/30/22.
//
// Diamond Shape

import SwiftUI

struct Diamond: InsettableShape{
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let topPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let bottomPoint = CGPoint(x: rect.midX, y: rect.minY)
        let leftPoint = CGPoint(x: rect.minX, y: rect.midY)
        let rightPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        var p = Path()
        p.move(to: topPoint)
        p.addLine(to: leftPoint)
        p.addLine(to: bottomPoint)
        p.addLine(to: rightPoint)
        p.addLine(to: topPoint)
        p.closeSubpath()
        return p
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var diamond = self
        diamond.insetAmount += amount
        return diamond
    }
}
