//
//  GridView.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 18/09/2023.
//

import Foundation
import UIKit

class GridView: UIView {
    var layoutType: LayoutType = .layout1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.blue
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        switch layoutType {
        case .layout1:
            let margin: CGFloat = 10.0
            let innerRect = rect.inset(by: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            
            let halfHeight = (innerRect.height - margin) / 2
            let fullWidth = innerRect.width
            let smallSquareWidth = (fullWidth - margin) / 2

            let rectangleRect = CGRect(x: innerRect.minX, y: innerRect.minY, width: fullWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(rectangleRect)
            
            let smallSquare1Rect = CGRect(x: innerRect.minX, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(smallSquare1Rect)
            
            let smallSquare2Rect = CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(smallSquare2Rect)
            
        case .layout2:
            let margin: CGFloat = 10.0
            let innerRect = rect.inset(by: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            
            let halfHeight = (innerRect.height - margin) / 2
            let fullWidth = innerRect.width
            let smallSquareWidth = (fullWidth - margin) / 2
            
            let smallSquare1Rect = CGRect(x: innerRect.minX, y: innerRect.minY, width: smallSquareWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(smallSquare1Rect)
            
            let smallSquare2Rect = CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY, width: smallSquareWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(smallSquare2Rect)

            let rectangleRect = CGRect(x: innerRect.minX, y: innerRect.minY + halfHeight + margin, width: fullWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(rectangleRect)

        case .layout3:
            let margin: CGFloat = 10.0
            let innerRect = rect.inset(by: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            
            let halfHeight = (innerRect.height - margin) / 2
            let fullWidth = innerRect.width
            let smallSquareWidth = (fullWidth - margin) / 2
            
            let smallSquare1Rect = CGRect(x: innerRect.minX, y: innerRect.minY, width: smallSquareWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(smallSquare1Rect)
            
            let smallSquare2Rect = CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY, width: smallSquareWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(smallSquare2Rect)

            let smallSquare3Rect = CGRect(x: innerRect.minX, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(smallSquare3Rect)
            
            let smallSquare4Rect = CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight)
            UIColor.white.setFill()
            UIRectFill(smallSquare4Rect)


        }
    }
}
