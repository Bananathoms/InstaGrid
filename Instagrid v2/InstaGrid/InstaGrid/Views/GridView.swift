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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
}

