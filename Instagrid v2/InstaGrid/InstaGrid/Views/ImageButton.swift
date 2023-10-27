//
//  ImageButton.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 23/09/2023.
//

import Foundation
import UIKit
import Photos
import PhotosUI

/// Custom UIButton subclass for selecting images.
class ImageButton: UIButton, PHPickerViewControllerDelegate {

    var imageSelectedHandler: ((UIImage?) -> Void)?
    var selectedImage: UIImage?
    var selectedButtonImage: UIImage? = UIImage(named: "Plus")

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureButton()
    }
    
    /// Configures the appearance and behavior of the button.
    private func configureButton() {
        setTitle("", for: .normal)
        setImage(self.selectedButtonImage, for: .normal)
        imageView?.contentMode = .scaleAspectFill
        backgroundColor = .white

        addTarget(self, action: #selector(self.imageButtonTapped), for: .touchUpInside)
    }
    
    /// Handles the tap event on the image button.
    @objc private func imageButtonTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.findViewController()?.present(picker, animated: true, completion: nil)
    }
}

extension ImageButton: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let imageProvider = results.first?.itemProvider, imageProvider.canLoadObject(ofClass: UIImage.self) {
            imageProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        let buttonSize = self?.frame.size ?? CGSize.zero
                        let scaledImage = image.scale(to: buttonSize)

                        self?.selectedImage = scaledImage
                        self?.setImage(scaledImage, for: .normal)
                        self?.imageSelectedHandler?(scaledImage)
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }


    func pickerDidCancel(_ picker: PHPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

