//
//  ImageButton.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 23/09/2023.
//

import Foundation
import UIKit
import Photos

class ImageButton: UIButton, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var imageSelectedHandler: ((UIImage?) -> Void)?
    var selectedImage: UIImage?
    var selectedButtonImage: UIImage? = UIImage(named: "Plus")

    
    init(frame: CGRect, image: UIImage?) {
        super.init(frame: frame)
        setImage(image, for: .normal)
        imageView?.contentMode = .center 
        backgroundColor = .white
        
        addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
    }
    
    @objc private func imageButtonTapped() {
        // Vérifiez si le périphérique dispose d'un accès à la bibliothèque de photos
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController?.present(imagePicker, animated: true, completion: nil)
            }
            
            self.imageSelectedHandler?(selectedImage)
            
            self.selectedButtonImage = selectedImage
            
        } else {
            // Gérer le cas où l'accès à la bibliothèque de photos n'est pas autorisé
            print("Accès à la bibliothèque de photos non autorisé.")
        }
    }
    
    // mise a jour de la selection d'image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            // Redimensionner l'image pour qu'elle s'adapte à la taille du bouton
            let buttonSize = self.frame.size
            let scaledImage = image.scale(to: buttonSize)
            
            self.selectedImage = scaledImage
            self.imageSelectedHandler?(self.selectedImage)
            self.selectedButtonImage = scaledImage
            setImage(self.selectedButtonImage, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
