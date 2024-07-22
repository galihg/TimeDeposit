//
//  SeparatorLineView.swift
//  TimeDeposit
//
//  Created by Kuncoro Galih Gemilang on 14/07/24.
//

import Foundation
import UIKit

final class SeparatorLine: UIView {
    
    enum Alignment {
        case horizontal
        case vertical
    }
    
    enum Pattern {
        case solid
        case dash
    }
    
    // MARK: - Properties
    
    var lineWidth: CGFloat = 1
    var lineLength: CGFloat = 4
    var lineGap: CGFloat = 4
    var alignment: Alignment?
    var lineColor: UIColor?
    var pattern: Pattern = .solid
    var dashedLayer: CAShapeLayer?
    var isViewRendered: Bool = false
    
    // MARK: - Life Cycle
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        isViewRendered = true
        guard bounds.width != dashedLayer?.frame.width else { return }
        
        drawDottedLine()
    }
    
    // MARK: - Drawing
    
    public func refresh() {
        
        if isViewRendered {
            drawDottedLine()
        }
    }
    
    private func drawDottedLine() {
        
        if dashedLayer != nil {
            dashedLayer?.removeFromSuperlayer()
        }
        
        let lineAlignment = alignment ?? getDefaultAlignment()
        var start = frame.origin
        var end: CGPoint = .zero
        
        if lineAlignment == .vertical {
            var x = (bounds.size.width / 2) - (lineWidth / 2)
            
            if x < 0 {
                x = 0
            }
            
            x += (lineWidth / 2)
            start = CGPoint(x: x, y: 0)
            end = CGPoint(x: x, y: bounds.size.height)
        } else {
            var y = (bounds.size.height / 2) - (lineWidth / 2)
            
            if y < 0 {
                y = 0
            }
            
            y += (lineWidth / 2)
            start = CGPoint(x: 0, y: y)
            end = CGPoint(x: bounds.size.width, y: y)
        }
        
        dashedLayer = drawDottedLine(
            start: start,
            end: end)
    }
    
    private func getDefaultAlignment() -> Alignment {
        return bounds.width < bounds.height ? .vertical : .horizontal
    }
    
    private func drawDottedLine(start: CGPoint, end: CGPoint) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = lineColor?.cgColor
        shapeLayer.lineWidth = lineWidth
        
        if pattern != .solid {
            shapeLayer.lineDashPattern = [lineLength as NSNumber, lineGap as NSNumber]
        }
        
        let path = CGMutablePath()
        path.addLines(between: [start, end])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        
        return shapeLayer
    }
}
