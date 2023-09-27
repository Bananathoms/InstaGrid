//
//  ViewController.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 19/09/2023.
//

import UIKit

class InstagridViewController: UIViewController {
    
    let selectedLayout = UIImage(named: "Selected")
    let layout1Image = UIImage(named: "Layout 1")
    let layout2Image = UIImage(named: "Layout 2")
    let layout3Image = UIImage(named: "Layout 3")

    
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

    }
    
    private func setupLayout(layoutType: LayoutType) {
        gridView.layoutType = layoutType

        switch layoutType {
        case .layout1:
            self.configureConstraints(leadUp: 280, trailUp: 0, leadDown: 135, trailDown: 135, trailUpHidden: true, trailDownHidden: false, trailUpTrail: 0, trailDownTrail: 10)
            self.updateButtonImages(leadUpSquare, leadDownSquare)
        case .layout2:
            self.configureConstraints(leadUp: 135, trailUp: 135, leadDown: 280, trailDown: 0, trailUpHidden: false, trailDownHidden: true, trailUpTrail: 10, trailDownTrail: 0)
            self.updateButtonImages(leadDownSquare, leadUpSquare)
        case .layout3:
            self.configureConstraints(leadUp: 135, trailUp: 135, leadDown: 135, trailDown: 135, trailUpHidden: false, trailDownHidden: false, trailUpTrail: 10, trailDownTrail: 10)
            self.updateButtonImages(leadUpSquare, leadDownSquare)
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

    private func updateButtonImages(_ selectedButton: ImageButton, _ otherButton: ImageButton) {
        if let image = selectedButton.selectedImage {
            let resizedImage = image.scale(to: CGSize(width: selectedButton.frame.width, height: selectedButton.frame.height))
            selectedButton.setImage(resizedImage, for: .normal)
        }
        otherButton.setImage(nil, for: .normal)
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


