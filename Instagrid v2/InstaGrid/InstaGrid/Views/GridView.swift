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
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.blue
    }
    
    // Fonction générique pour ajouter un carré à une position donnée
    private func addSquare(atRect rect: CGRect) {
        let squareImageView = UIImageView(frame: rect)
        squareImageView.backgroundColor = UIColor.white
        self.addSubview(squareImageView)
    }
    
    // Fonction générique pour ajouter un rectangle à une position donnée
    private func addRectangle(atRect rect: CGRect) {
        let rectangleImageView = UIImageView(frame: rect)
        rectangleImageView.backgroundColor = UIColor.white
        self.addSubview(rectangleImageView)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        switch layoutType {
        case .layout1:
            
            self.subviews.forEach { $0.removeFromSuperview() }
            
            let margin: CGFloat = 10.0
            let innerRect = rect.inset(by: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            
            let halfHeight = (innerRect.height - margin) / 2
            let fullWidth = innerRect.width
            let smallSquareWidth = (fullWidth - margin) / 2
            
            // Ajoutez des carrés et des rectangles en utilisant les fonctions génériques
            addRectangle(atRect: CGRect(x: innerRect.minX, y: innerRect.minY, width: fullWidth, height: halfHeight))
            addSquare(atRect: CGRect(x: innerRect.minX, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight))
            addSquare(atRect: CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight))
            
            
        case .layout2:
            self.subviews.forEach { $0.removeFromSuperview() }
            
            let margin: CGFloat = 10.0
            let innerRect = rect.inset(by: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            
            let halfHeight = (innerRect.height - margin) / 2
            let fullWidth = innerRect.width
            let smallSquareWidth = (fullWidth - margin) / 2

            // Ajoutez des carrés et des rectangles en utilisant les fonctions génériques
            addSquare(atRect: CGRect(x: innerRect.minX, y: innerRect.minY, width: smallSquareWidth, height: halfHeight))
            addSquare(atRect: CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY, width: smallSquareWidth, height: halfHeight))
            addRectangle(atRect: CGRect(x: innerRect.minX, y: innerRect.minY + halfHeight + margin, width: fullWidth, height: halfHeight))

        case .layout3:
            self.subviews.forEach { $0.removeFromSuperview() }
            
            let margin: CGFloat = 10.0
            let innerRect = rect.inset(by: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
            
            let halfHeight = (innerRect.height - margin) / 2
            let fullWidth = innerRect.width
            let smallSquareWidth = (fullWidth - margin) / 2

            // Ajoutez des carrés et des rectangles en utilisant les fonctions génériques
            addSquare(atRect: CGRect(x: innerRect.minX, y: innerRect.minY, width: smallSquareWidth, height: halfHeight))
            addSquare(atRect: CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY, width: smallSquareWidth, height: halfHeight))
            addSquare(atRect: CGRect(x: innerRect.minX, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight))
            addSquare(atRect: CGRect(x: innerRect.minX + smallSquareWidth + margin, y: innerRect.minY + halfHeight + margin, width: smallSquareWidth, height: halfHeight))


        }
    }
}
