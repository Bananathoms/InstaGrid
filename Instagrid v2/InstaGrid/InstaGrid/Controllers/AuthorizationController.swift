//
//  AuthorizationController.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 30/09/2023.
//

import Foundation
import Photos
import UIKit

/// This class manages authorization for accessing the photo library.
class AuthorizationController {
    /// Checks if access to the photo library is allowed.
    /// - Returns: `true` if access is authorized, otherwise `false`.
    static func isPhotoLibraryAccessAllowed() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        return status == .authorized
    }
    
    /// Requests access to the photo library and invokes the completion handler with the result.
    /// - Parameter completion: A closure that receives a boolean indicating whether access was granted (`true`) or denied (`false`).
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



