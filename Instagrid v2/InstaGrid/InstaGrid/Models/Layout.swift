//
//  Layout.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 19/09/2023.
//

import Foundation
import UIKit

/// Enum to represent different grid layout types.
enum LayoutType: Int {
    case layout1 = 1
    case layout2 = 2
    case layout3 = 3
}

/// Class to represent a layout with a specified type.
class Layout {
    var type: LayoutType
    
    init(type: LayoutType) {
        self.type = type
    }
}
