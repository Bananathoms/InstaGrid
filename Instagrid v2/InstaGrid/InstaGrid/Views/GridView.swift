//
//  GridView.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 19/09/2023.
//

import Foundation
import UIKit

/// Custom view representing the grid layout for photos.
class GridView: UIView {
    
    weak var delegate: GridViewDelegate?
    var layoutType: LayoutType = .layout1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSwipeGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    /// Sets up a swipe-up gesture recognizer on the grid view.
    private func setupSwipeGesture() {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeUp(_:)))
        swipeUpGesture.direction = .up
        self.addGestureRecognizer(swipeUpGesture)
    }
    
    /// Handles the swipe-up gesture and notifies the delegate.
    /// - Parameter gesture: The swipe gesture recognizer.
    @objc private func handleSwipeUp(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            self.delegate?.gridViewDidSwipeUp(self)
        }
    }
}

/// Protocol to notify a delegate when a swipe-up gesture occurs in the grid view.
protocol GridViewDelegate: AnyObject {
    func gridViewDidSwipeUp(_ gridView: GridView)
}

