//
//  Extension.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 24/09/2023.
//

import Foundation
import UIKit

extension UIView {
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
