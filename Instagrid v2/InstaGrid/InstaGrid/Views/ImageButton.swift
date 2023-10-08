//
//  ImageButton.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 23/09/2023.
//

import Foundation
import UIKit
import Photos

/// Custom UIButton subclass for selecting images.
class ImageButton: UIButton {
    
    var imageSelectedHandler: ((UIImage?) -> Void)?
    var selectedImage: UIImage?
    var selectedButtonImage: UIImage? = UIImage(named: "Plus")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    /// Configures the appearance and behavior of the button.
    private func configureButton() {
        setTitle("", for: .normal)
        setImage(selectedButtonImage, for: .normal)
        imageView?.contentMode = .scaleAspectFill
        backgroundColor = .white

        addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
    }
    
    /// Handles the tap event on the image button.
    @objc private func imageButtonTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            findViewController()?.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension ImageButton: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /// Handles the image selection from the image picker.
    /// - Parameters:
    ///   - picker: The image picker controller.
    ///   - info: The selected image info.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let buttonSize = self.frame.size
            let scaledImage = image.scale(to: buttonSize)

            selectedImage = scaledImage
            setImage(selectedImage, for: .normal)
            imageSelectedHandler?(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    /// Handles the cancellation of image selection from the image picker.
    /// - Parameter picker: The image picker controller.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
