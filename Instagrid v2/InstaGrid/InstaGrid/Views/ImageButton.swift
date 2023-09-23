//
//  ImageButton.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 23/09/2023.
//

import Foundation
import UIKit

class ImageButton: UIButton {
    init(frame: CGRect, image: UIImage?) {
        super.init(frame: frame)
        setImage(image, for: .normal)
        imageView?.contentMode = .center 
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
