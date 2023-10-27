//
//  ViewController.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 19/09/2023.
//

import UIKit
import Photos

/// Main view controller for the Instagrid app.
class InstagridViewController: UIViewController, GridViewDelegate, ImageButtonDelegate {
    
    /// Images for layout selection buttons.
    let selectedLayout = UIImage(named: "Selected")
    let layout1Image = UIImage(named: "Layout 1")
    let layout2Image = UIImage(named: "Layout 2")
    let layout3Image = UIImage(named: "Layout 3")
    
    /// Flag to track photo library access.
    var isPhotoLibraryAccessAllowed = false

    /// Outlets for various UI elements.
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var layout1Button: UIImageView!
    @IBOutlet weak var layout2Button: UIImageView!
    @IBOutlet weak var layout3Button: UIImageView!
    @IBOutlet weak var leadUpSquare: ImageButton!
    @IBOutlet weak var trailUpSquare: ImageButton!
    @IBOutlet weak var leadDownSquare: ImageButton!
    @IBOutlet weak var trailDownSquare: ImageButton!
    @IBOutlet weak var swipeStack: UIStackView!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var leadUpWidhtConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailUpWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadDownWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailDownWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailUpTrailConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailDownTrailConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gridView.delegate = self
        self.setupLayout(layoutType: .layout1)
        self.createSwipeGesture()
        self.leadUpSquare.delegate = self
        self.trailUpSquare.delegate = self
        self.leadDownSquare.delegate = self
        self.trailDownSquare.delegate = self
        
        /// Orientation observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    /// Called when the device orientation changes.
    @objc func orientationChanged() {
        /// device orientation
        let orientation = UIDevice.current.orientation
        
        switch orientation {
        case .portrait, .portraitUpsideDown:
            self.enableSwipeUpGesture()
            self.disableSwipeLeftGesture()
            self.stackview.axis = .horizontal
        case .landscapeLeft, .landscapeRight:
            self.enableSwipeLeftGesture()
            self.disableSwipeUpGesture()
            self.stackview.axis = .vertical
        default:
            break
        }
    }
    
    /// Enables swipe up gesture.
    func enableSwipeUpGesture() {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(with:)))
        swipeUpGesture.direction = .up
        self.view.addGestureRecognizer(swipeUpGesture)
        
        if let swipeLeftGesture = self.view.gestureRecognizers?.first(where: { ($0 as? UISwipeGestureRecognizer)?.direction == .left }) {
            self.view.removeGestureRecognizer(swipeLeftGesture)
        }
    }
    
    /// Disables swipe up gesture.
    func disableSwipeUpGesture() {
        if let swipeUpGesture = self.view.gestureRecognizers?.first(where: { ($0 as? UISwipeGestureRecognizer)?.direction == .up }) {
            self.view.removeGestureRecognizer(swipeUpGesture)
        }
    }
    
    /// nables swipe left gesture.
    func enableSwipeLeftGesture() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(with:)))
        swipeLeftGesture.direction = .left
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        if let swipeUpGesture = self.view.gestureRecognizers?.first(where: { ($0 as? UISwipeGestureRecognizer)?.direction == .up }) {
            self.view.removeGestureRecognizer(swipeUpGesture)
        }
    }
    
    /// Disables swipe left gesture.
    func disableSwipeLeftGesture() {
        if let swipeLeftGesture = self.view.gestureRecognizers?.first(where: { ($0 as? UISwipeGestureRecognizer)?.direction == .left }) {
            self.view.removeGestureRecognizer(swipeLeftGesture)
        }
    }

    /// Delegate method called when the grid view is swiped up.
    func gridViewDidSwipeUp(_ gridView: GridView) {
        //expliquer pourquoi vide : methode obligatoire
    }
    
    /// Creates swipe gestures for handling user interaction.
    private func createSwipeGesture() {
        var swipeUp = [UISwipeGestureRecognizer]()
        var swipeLeft = [UISwipeGestureRecognizer]()
        
        swipeUp.append(UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(with:))))
        swipeUp[0].direction = .up
        swipeUp.append(UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(with:))))
        swipeUp[1].direction = .up
        self.view.addGestureRecognizer(swipeUp[0])
        
        swipeLeft.append(UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(with:))))
        swipeLeft[0].direction = .left
        swipeLeft.append(UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(with:))))
        swipeLeft[1].direction = .left
        self.view.addGestureRecognizer(swipeUp[0])
    }
    
    /// Handles swipe gestures.
    /// - Parameter gesture: Parameter gesture: The swipe gesture.
    @objc func swipeGesture(with gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            self.moveViewVertically(.out)
            if let capturedImage = self.captureGridViewImage() {
                self.shareImage(capturedImage, deviceOrientation: "portrait")
            }
        case .left:
            self.moveViewHorizontally(.out)
            if let capturedImage = self.captureGridViewImage() {
                self.shareImage(capturedImage, deviceOrientation: "landscape")
            }
        default:
            break
        }
    }
    
    /// Shares the captured image with the device's sharing options.
    /// - Parameters:
    ///   - imageToShare: The image to share.
    ///   - deviceOrientation: The device's orientation (portrait or landscape).
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
    
    /// Moves the view vertically based on the specified movement direction.
    /// - Parameter movement: The direction in which to move the view.
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
    
    /// oves the view horizontally based on the specified movement direction.
    /// - Parameter movement: Parameter movement: The direction in which to move the view.
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
    
    /// Captures an image of the gridView.
    /// - Returns: The captured UIImage.
    func captureGridViewImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.gridView.bounds.size, self.gridView.isOpaque, 0)
        defer { UIGraphicsEndImageContext() }
        self.gridView.drawHierarchy(in: self.gridView.bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func imageButtonAccessDenied() {
        let alertController = UIAlertController(
            title: "Photo Library Access Denied",
            message: "To use this feature, please allow access to the photo library in the app settings.",
            preferredStyle: .alert
        )

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    /// Enables features related to photo library access.
    func enablePhotoLibraryFeatures() {
        self.leadUpSquare.isUserInteractionEnabled = true
        self.trailUpSquare.isUserInteractionEnabled = true
        self.leadDownSquare.isUserInteractionEnabled = true
        self.trailDownSquare.isUserInteractionEnabled = true
        
    }

    /// Sets up the grid layout based on the specified `LayoutType`.
    /// - Parameter layoutType: The layout type to be set.
    private func setupLayout(layoutType: LayoutType) {
        self.gridView.layoutType = layoutType

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
    
    /// Configures constraints for the layout based on the layout type.
    /// - Parameters:
    ///   - leadUp: Leading constraint for the upper square.
    ///   - trailUp: Trailing constraint for the upper square.
    ///   - leadDown: Leading constraint for the lower square
    ///   - trailDown: Trailing constraint for the lower square.
    ///   - trailUpHidden: Whether the upper square should be hidden.
    ///   - trailDownHidden: Whether the lower square should be hidden.
    ///   - trailUpTrail: Trailing constraint for the upper square (used when hidden).
    ///   - trailDownTrail: Trailing constraint for the lower square (used when hidden).
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
    
    /// esizes an image for a button with specified width and height.
    /// - Parameters:
    ///   - button: The button whose image will be resized.
    ///   - width: The target width for the image.
    ///   - height: The target height for the image.
    private func resizeImageForButton(_ button: ImageButton, width: CGFloat, height: CGFloat) {
        if let image = button.selectedImage {
            let resizedImage = self.resizeImage(image: image, width: width, height: height)
            button.setImage(resizedImage, for: .normal)
        }
    }
    
    /// Resizes an image to the specified dimensions.
    /// - Parameters:
    ///   - image: The image to be resized.
    ///   - width: The target width for the image.
    ///   - height: The target height for the image.
    /// - Returns: The resized image.
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

    /// Handler for the tap gesture on the layout 1 button.
    /// - Parameter sender: The UITapGestureRecognizer triggering the action.
    @IBAction func layout1ImageTapped(_ sender: UITapGestureRecognizer) {
        self.setupLayout(layoutType: .layout1)
        self.layout1Button.image = self.selectedLayout
        self.layout2Button.image = self.layout2Image
        self.layout3Button.image = self.layout3Image
    }
    
    /// Handler for the tap gesture on the layout 2 button.
    /// - Parameter sender: The UITapGestureRecognizer triggering the action.
    @IBAction func layout2ImageTapped(_ sender: UITapGestureRecognizer) {
        self.setupLayout(layoutType: .layout2)
        self.layout1Button.image = self.layout1Image
        self.layout2Button.image = self.selectedLayout
        self.layout3Button.image = self.layout3Image
    }
    
    /// Handler for the tap gesture on the layout 3 button.
    /// - Parameter sender: The UITapGestureRecognizer triggering the action.
    @IBAction func layout3ImageTapped(_ sender: UITapGestureRecognizer) {
        self.setupLayout(layoutType: .layout3)
        self.layout1Button.image = self.layout1Image
        self.layout2Button.image = self.layout2Image
        self.layout3Button.image = self.selectedLayout
    }

}
