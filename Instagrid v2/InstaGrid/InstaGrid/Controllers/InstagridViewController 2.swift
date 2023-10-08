//
//  ViewController.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 19/09/2023.
//

import UIKit
import Photos

class InstagridViewController: UIViewController, GridViewDelegate {
    
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
    
    @IBOutlet weak var swipeStack: UIStackView!
    
    @IBOutlet weak var leadUpWidhtConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailUpWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadDownWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailDownWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailUpTrailConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailDownTrailConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.delegate = self
        setupLayout(layoutType: .layout1)
        self.createSwipeGesture()
        
        
         /// Ask library acces
         let status = PHPhotoLibrary.authorizationStatus()
         
         switch status {
         case .authorized:
             /// acces authorized to all photos
             self.isPhotoLibraryAccessAllowed = true
         case .notDetermined:
             /// acces not determined
             PHPhotoLibrary.requestAuthorization { [self] status in
                 DispatchQueue.main.async {
                     if status == .authorized {
                         self.enablePhotoLibraryFeatures()
                         self.isPhotoLibraryAccessAllowed = true
                     } else {
                         self.disablePhotoLibraryFeatures()
                     }
                 }
             }
         default:
             self.disablePhotoLibraryFeatures()
             break
         }
        
        /// Orientation observer
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)

    }
    
    
    @objc func orientationChanged() {
        /// device orientation
        let orientation = UIDevice.current.orientation
        
        switch orientation {
        case .portrait, .portraitUpsideDown:
            enableSwipeUpGesture()
            disableSwipeLeftGesture()
        case .landscapeLeft, .landscapeRight:
            enableSwipeLeftGesture()
            disableSwipeUpGesture()
        default:
            break
        }
    }
    
    func enableSwipeUpGesture() {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:)))
        swipeUpGesture.direction = .up
        self.view.addGestureRecognizer(swipeUpGesture)
        
        if let swipeLeftGesture = self.view.gestureRecognizers?.first(where: { ($0 as? UISwipeGestureRecognizer)?.direction == .left }) {
            self.view.removeGestureRecognizer(swipeLeftGesture)
        }
    }
    
    func disableSwipeUpGesture() {
        if let swipeUpGesture = self.view.gestureRecognizers?.first(where: { ($0 as? UISwipeGestureRecognizer)?.direction == .up }) {
            self.view.removeGestureRecognizer(swipeUpGesture)
        }
    }

    func enableSwipeLeftGesture() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:)))
        swipeLeftGesture.direction = .left
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        if let swipeUpGesture = self.view.gestureRecognizers?.first(where: { ($0 as? UISwipeGestureRecognizer)?.direction == .up }) {
            self.view.removeGestureRecognizer(swipeUpGesture)
        }
    }
    
    func disableSwipeLeftGesture() {
        if let swipeLeftGesture = self.view.gestureRecognizers?.first(where: { ($0 as? UISwipeGestureRecognizer)?.direction == .left }) {
            self.view.removeGestureRecognizer(swipeLeftGesture)
        }
    }

    
    func gridViewDidSwipeUp(_ gridView: GridView) {
        
    }
    
    private func createSwipeGesture() {
        var swipeUp = [UISwipeGestureRecognizer]()
        var swipeLeft = [UISwipeGestureRecognizer]()
        
        swipeUp.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeUp[0].direction = .up
        swipeUp.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeUp[1].direction = .up
        self.view.addGestureRecognizer(swipeUp[0])
        
        swipeLeft.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeLeft[0].direction = .left
        swipeLeft.append(UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(with:))))
        swipeLeft[1].direction = .left
        self.view.addGestureRecognizer(swipeUp[0])
    }
    
    @objc func swipeGesture(with gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            moveViewVertically(.out)
            if let capturedImage = captureGridViewImage() {
                shareImage(capturedImage, deviceOrientation: "portrait")
            }
        case .left:
            moveViewHorizontally(.out)
            if let capturedImage = captureGridViewImage() {
                shareImage(capturedImage, deviceOrientation: "landscape")
            }
        default:
            break
        }
    }

    private func shareImage(_ imageToShare: UIImage, deviceOrientation: String) {
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        
        switch deviceOrientation {
        case "portrait":
            activityViewController.completionWithItemsHandler = { [weak self] (_, completed, _, _) in
                self?.moveViewVertically(.backIn)
            }
        case "landscape":
            activityViewController.completionWithItemsHandler = { [weak self] (_, completed, _, _) in
                self?.moveViewHorizontally(.backIn)
            }
        default:
            break
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func moveViewVertically(_ movement: ViewDirection) {
        switch movement {
        case .out:
            UIView.animate(withDuration: 0.5) {
                self.gridView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
                self.swipeStack.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }
        case .backIn:
            UIView.animate(withDuration: 0.5) {
                self.gridView.transform = .identity
                self.swipeStack.transform = .identity
            }
        }
    }

    private func moveViewHorizontally(_ movement: ViewDirection) {
        switch movement {
        case .out:
            UIView.animate(withDuration: 0.5) {
                self.gridView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            }
        case .backIn:
            UIView.animate(withDuration: 0.5) {
                self.gridView.transform = .identity
            }
        }
    }

    func captureGridViewImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(gridView.bounds.size, gridView.isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        gridView.drawHierarchy(in: gridView.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func enablePhotoLibraryFeatures() {
        self.leadUpSquare.isUserInteractionEnabled = true
        self.trailUpSquare.isUserInteractionEnabled = true
        self.leadDownSquare.isUserInteractionEnabled = true
        self.trailDownSquare.isUserInteractionEnabled = true
        
    }
    
    func disablePhotoLibraryFeatures() {
        let alertController = UIAlertController(
            title: "Accès à la bibliothèque de photos refusé",
            message: "Pour utiliser cette fonctionnalité, veuillez autoriser l'accès à la bibliothèque de photos dans les paramètres de l'application.",
            preferredStyle: .alert
            //ajouter un lien vers les reglages
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

    
    
    // Méthode appelée lorsque vous voulez ouvrir la vue de sélection
    func openSelectionView() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .limited {
            // L'accès à la bibliothèque de photos est limité, déclenchez le segue
            performSegue(withIdentifier: "ShowSelectionViewSegue", sender: nil)
        } else {
            // L'accès à la bibliothèque de photos est autorisé ou refusé
            // Faites ce que vous voulez en conséquence
        }
    }
    
    // Cette méthode est appelée avant de déclencher le segue
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "ShowSelectionViewSegue" {
              // Assurez-vous que vous avez un segue avec cet identifiant
              if let destinationVC = segue.destination as? SelectionViewController {
                  // Vous pouvez passer des données à SelectionViewController si nécessaire
                  // Par exemple, vous pourriez lui transmettre des paramètres pour personnaliser son comportement
                  // destinationVC.someProperty = someValue
              }
          }
      }
    
}


