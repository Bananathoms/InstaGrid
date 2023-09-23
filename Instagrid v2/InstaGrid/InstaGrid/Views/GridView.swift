//
//  GridView.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 19/09/2023.
//

import Foundation
import UIKit
import UIKit

class GridView: UIView {
    var layoutType: LayoutType = .layout1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.marginColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.marginColor()
    }
    
    private func marginColor() {
        backgroundColor = UIColor.blue
    }
    
    // Fonction générique pour ajouter un carré à une position donnée
    private func addSquare(atRect rect: CGRect, image: UIImage? = UIImage(named: "Plus")) {
        let squareImageView = UIImageView(frame: rect)
        squareImageView.backgroundColor = UIColor.white
        squareImageView.image = image
        squareImageView.contentMode = .center
        self.addSubview(squareImageView)
    }
    
    // Fonction générique pour ajouter un rectangle à une position donnée
    private func addRectangle(atRect rect: CGRect, image: UIImage? = UIImage(named: "Plus")) {
        let rectangleImageView = UIImageView(frame: rect)
        rectangleImageView.backgroundColor = UIColor.white
        rectangleImageView.image = image
        rectangleImageView.contentMode = .center
        self.addSubview(rectangleImageView)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let margin: CGFloat = 10.0
        let innerRect = rect.inset(by: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
        
        let halfHeight = (innerRect.height - margin) / 2
        let fullWidth = innerRect.width
        let smallSquareWidth = (fullWidth - margin) / 2
        
        switch self.layoutType {
        case .layout1:
            
            self.subviews.forEach { $0.removeFromSuperview() }
  
            self.addRectangle(atRect: CGRect(x: innerRect.minX, y: innerRect.minY, width: fullWidth, height: halfHeight))
            self.addSquare(atRect: CGRect(x: innerRect.minX, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight))
            self.addSquare(atRect: CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight))
            
        case .layout2:
            self.subviews.forEach { $0.removeFromSuperview() }
 
            self.addSquare(atRect: CGRect(x: innerRect.minX, y: innerRect.minY, width: smallSquareWidth, height: halfHeight))
            self.addSquare(atRect: CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY, width: smallSquareWidth, height: halfHeight))
            self.addRectangle(atRect: CGRect(x: innerRect.minX, y: innerRect.minY + halfHeight + margin, width: fullWidth, height: halfHeight))

        case .layout3:
            self.subviews.forEach { $0.removeFromSuperview() }
            
            self.addSquare(atRect: CGRect(x: innerRect.minX, y: innerRect.minY, width: smallSquareWidth, height: halfHeight))
            self.addSquare(atRect: CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY, width: smallSquareWidth, height: halfHeight))
            self.addSquare(atRect: CGRect(x: innerRect.minX, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight))
            self.addSquare(atRect: CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight))


        }
    }
}
