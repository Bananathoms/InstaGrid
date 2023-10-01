//
//  ImageButton.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 23/09/2023.
//

import Foundation
import UIKit
import Photos

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

    private func configureButton() {
        setTitle("", for: .normal)
        setImage(selectedButtonImage, for: .normal)
        imageView?.contentMode = .scaleAspectFill
        backgroundColor = .white

        addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
    }

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

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
