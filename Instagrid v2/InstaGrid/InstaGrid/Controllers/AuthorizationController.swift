//
//  AuthorizationController.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 30/09/2023.
//

import Foundation
import Photos
import UIKit

class AuthorizationController {

    // Vérifie si l'accès à la bibliothèque photo est autorisé
    static func isPhotoLibraryAccessAllowed() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        return status == .authorized
    }
    
    func requestPhotoLibraryAccess(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            // L'accès à la bibliothèque est déjà autorisé
            completion(true)
        case .denied, .restricted:
            // L'accès à la bibliothèque est refusé ou restreint
            completion(false)
        case .notDetermined:
            // Vous n'avez pas encore demandé l'accès, demandez-le maintenant.
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    completion(status == .authorized)
                }
            }
        case .limited:
            // L'accès à la bibliothèque est limité
            completion(true) // Vous pouvez choisir de considérer cela comme une autorisation réussie ou gérer le cas différemment selon vos besoins.
        default:
            // Autres cas non gérés
            completion(false)
        }
    }


}



