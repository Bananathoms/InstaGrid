//
//  ViewController.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 19/09/2023.
//

import UIKit
import Photos

class InstagridViewController: UIViewController {
    
    let selectedLayout = UIImage(named: "Selected")
    let layout1Image = UIImage(named: "Layout 1")
    let layout2Image = UIImage(named: "Layout 2")
    let layout3Image = UIImage(named: "Layout 3")
    
    var isPhotoLibraryAccessAllowed = false

    @IBOutlet weak var gridView: GridView!
    
    @IBOutlet weak var layout1Button: UIImageView!
    @IBOutlet weak var layout2Button: UIImageView!
    @IBOutlet weak var layout3Button: UIImageView!
    
    @IBOutlet weak var leadUpSquare: ImageButton!
    @IBOutlet weak var trailUpSquare: ImageButton!
    @IBOutlet weak var leadDownSquare: ImageButton!
    @IBOutlet weak var trailDownSquare: ImageButton!
    
    @IBOutlet weak var leadUpWidhtConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailUpWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadDownWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailDownWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailUpTrailConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailDownTrailConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout(layoutType: .layout1)
        
        
         // Vérifiez si vous avez déjà demandé l'accès à la bibliothèque
         let status = PHPhotoLibrary.authorizationStatus()
         
         switch status {
         case .authorized:
             // L'accès à la bibliothèque est déjà autorisé, vous pouvez accéder aux photos ici.
             self.isPhotoLibraryAccessAllowed = true
         case .notDetermined:
             // Vous n'avez pas encore demandé l'accès, demandez-le maintenant.
             PHPhotoLibrary.requestAuthorization { [self] status in
                 DispatchQueue.main.async {
                     if status == .authorized {
                         self.enablePhotoLibraryFeatures()
                         self.isPhotoLibraryAccessAllowed = true
                     } else {
                         // L'accès a été refusé ou restreint, montrez l'alerte.
                         self.disablePhotoLibraryFeatures()
                     }
                 }
             }
         default:
             // L'accès a été refusé ou restreint, montrez l'alerte.
             self.disablePhotoLibraryFeatures()
             break
         }
    }
    
    func enablePhotoLibraryFeatures() {
        // Activez ici les fonctionnalités liées à la bibliothèque photo
        // Par exemple, activez les ImageButton.
        self.leadUpSquare.isUserInteractionEnabled = true
        self.trailUpSquare.isUserInteractionEnabled = true
        self.leadDownSquare.isUserInteractionEnabled = true
        self.trailDownSquare.isUserInteractionEnabled = true
        
        // Montrez ici les éléments de l'interface utilisateur qui permettent d'accéder à la bibliothèque photo
    }
    
    func disablePhotoLibraryFeatures() {
        // Désactivez ici les fonctionnalités liées à la bibliothèque photo
        // Par exemple, vous pouvez désactiver les boutons qui permettent d'accéder à la bibliothèque.
        
        // Affichez un message d'information à l'utilisateur
        let alertController = UIAlertController(
            title: "Accès à la bibliothèque de photos refusé",
            message: "Pour utiliser cette fonctionnalité, veuillez autoriser l'accès à la bibliothèque de photos dans les paramètres de l'application.",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
        self.leadUpSquare.isUserInteractionEnabled = false
        self.trailUpSquare.isUserInteractionEnabled = false
        self.leadDownSquare.isUserInteractionEnabled = false
        self.trailDownSquare.isUserInteractionEnabled = false
    }


    
    private func setupLayout(layoutType: LayoutType) {
        gridView.layoutType = layoutType

        switch layoutType {
        case .layout1:
            self.configureConstraints(leadUp: 280, trailUp: 0, leadDown: 135, trailDown: 135, trailUpHidden: true, trailDownHidden: false, trailUpTrail: 0, trailDownTrail: 10)
            self.resizeImageForButton(leadUpSquare, width: 280, height: 135)
            self.resizeImageForButton(leadDownSquare, width: 135, height: 135)
        case .layout2:
            self.configureConstraints(leadUp: 135, trailUp: 135, leadDown: 280, trailDown: 0, trailUpHidden: false, trailDownHidden: true, trailUpTrail: 10, trailDownTrail: 0)
            self.resizeImageForButton(leadUpSquare, width: 135, height: 135)
            self.resizeImageForButton(leadDownSquare, width: 280, height: 135)
        case .layout3:
            self.configureConstraints(leadUp: 135, trailUp: 135, leadDown: 135, trailDown: 135, trailUpHidden: false, trailDownHidden: false, trailUpTrail: 10, trailDownTrail: 10)
            self.resizeImageForButton(leadUpSquare, width: 135, height: 135)
            self.resizeImageForButton(leadDownSquare, width: 135, height: 135)
        }
    }

    private func configureConstraints(leadUp: CGFloat, trailUp: CGFloat, leadDown: CGFloat, trailDown: CGFloat, trailUpHidden: Bool, trailDownHidden: Bool, trailUpTrail: CGFloat, trailDownTrail: CGFloat) {
        
        self.leadUpWidhtConstraint.constant = leadUp
        self.trailUpWidthConstraint.constant = trailUp
        self.leadDownWidthConstraint.constant = leadDown
        self.trailDownWidthConstraint.constant = trailDown

        self.trailUpSquare.isHidden = trailUpHidden
        self.trailDownSquare.isHidden = trailDownHidden

        self.trailUpTrailConstraint.constant = trailUpTrail
        self.trailDownTrailConstraint.constant = trailDownTrail
    }

    private func resizeImageForButton(_ button: ImageButton, width: CGFloat, height: CGFloat) {
        if let image = button.selectedImage {
            let resizedImage = resizeImage(image: image, width: width, height: height)
            button.setImage(resizedImage, for: .normal)
        }
    }

    private func resizeImage(image: UIImage?, width: CGFloat, height: CGFloat) -> UIImage? {
        guard let image = image else {
            return nil
        }
        
        let newSize = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }

    
    @IBAction func layout1ImageTapped(_ sender: UITapGestureRecognizer) {
        self.setupLayout(layoutType: .layout1)
        
        self.layout1Button.image = selectedLayout
        self.layout2Button.image = layout2Image
        self.layout3Button.image = layout3Image
    }

    @IBAction func layout2ImageTapped(_ sender: UITapGestureRecognizer) {
        self.setupLayout(layoutType: .layout2)
        
        self.layout1Button.image = layout1Image
        self.layout2Button.image = selectedLayout
        self.layout3Button.image = layout3Image
    }

    @IBAction func layout3ImageTapped(_ sender: UITapGestureRecognizer) {
        self.setupLayout(layoutType: .layout3)
        
        self.layout1Button.image = layout1Image
        self.layout2Button.image = layout2Image
        self.layout3Button.image = selectedLayout
    }

}


