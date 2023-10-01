//
//  GridView.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 19/09/2023.
//

import Foundation
import UIKit


protocol GridViewDelegate: AnyObject {
    func gridViewDidSwipeUp(_ gridView: GridView)
}

class GridView: UIView {
    
    var delegate: GridViewDelegate?
    
    var layoutType: LayoutType = .layout1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwipeGesture()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    private func setupSwipeGesture() {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp(_:)))
        swipeUpGesture.direction = .up
        self.addGestureRecognizer(swipeUpGesture)
    }

    @objc private func handleSwipeUp(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            // Appel de la délégation pour informer qu'un swipe vers le haut a été effectué
            delegate?.gridViewDidSwipeUp(self)
        }
    }
}

