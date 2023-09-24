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
            imagePicker.delegate = self // Assurez-vous que votre ViewController adopte le protocole UIImagePickerControllerDelegate
            // Vous pouvez également configurer d'autres propriétés de UIImagePickerController ici, telles que l'édition de l'image.
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        } else {
            // Gérer le cas où l'accès à la bibliothèque de photos n'est pas autorisé
            // Par exemple, vous pouvez afficher un message d'erreur à l'utilisateur.
            print("Accès à la bibliothèque de photos non autorisé.")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
