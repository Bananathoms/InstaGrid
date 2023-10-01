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
    static func isPhotoLibraryAccessAllowed() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        return status == .authorized
    }
    
    func requestPhotoLibraryAccess(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    completion(status == .authorized)
                }
            }
        case .limited:
            completion(true)
        default:
            completion(false)
        }
    }
}



