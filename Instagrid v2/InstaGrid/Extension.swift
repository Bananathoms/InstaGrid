//
//  Extension.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 24/09/2023.
//

import Foundation
import UIKit

extension UIView {
    /// Finds and returns the view controller that contains this UIView.
    /// - Returns: The parent view controller or nil if not found.
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let currentResponder = responder {
            if let viewController = currentResponder as? UIViewController {
                return viewController
            }
            responder = currentResponder.next
        }
        return nil
    }
}

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
