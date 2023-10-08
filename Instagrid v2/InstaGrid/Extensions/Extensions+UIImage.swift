//
//  Extensions+UIImage.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 08/10/2023.
//

import Foundation
import UIKit

extension UIImage {
    /// Scales the image to the specified size.
    /// - Parameter size: The target size for the scaled image.
    /// - Returns: The scaled UIImage.
    func scale(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: size))
        if let scaledImage = UIGraphicsGetImageFromCurrentImageContext() {
            return scaledImage
        }
        return self
    }
}
