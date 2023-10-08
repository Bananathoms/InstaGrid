//
//  RenderViewToImage.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 01/10/2023.
//

import Foundation
import UIKit

/// A utility class for rendering a UIView to an image.
class RenderViewToImage: UIImage {
    
    /// Renders the given view to an image.
    /// - Parameters:
    ///   - view: The UIView to be rendered.
    ///   - defaultImage: The default image to return if rendering fails.
    /// - Returns: The rendered UIImage or the default image.
    static func render(_ view: UIView, defaultImage: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext() ?? defaultImage
    }
    
}
