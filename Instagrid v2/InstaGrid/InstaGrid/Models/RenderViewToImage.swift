//
//  RenderViewToImage.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 01/10/2023.
//

import Foundation
import UIKit

class RenderViewToImage: UIImage {
    
    static func render(_ view: UIView, defaultImage: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext() ?? defaultImage
    }
    
}
