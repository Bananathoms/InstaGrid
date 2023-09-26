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
    
    @IBOutlet weak var leadUpSquare: ImageButton!
    
    @IBOutlet weak var trailUpSquare: ImageButton!
    
    @IBOutlet weak var leadDownSquare: ImageButton!
    
    @IBOutlet weak var trailDownSquare: ImageButton!
    
    @IBOutlet weak var gridView: GridView!
    
    @IBOutlet weak var layout1Button: UIImageView!
    @IBOutlet weak var layout2Button: UIImageView!
    @IBOutlet weak var layout3Button: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBOutlet weak var leadUpWidhtConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailUpWidthConstraint: NSLayoutConstraint!
    
    
    
    @IBAction func layout1ImageTapped(_ sender: UITapGestureRecognizer) {
        self.gridView.layoutType = .layout1
        self.layout1Button.image = selectedLayout
        self.layout2Button.image = layout2Image
        self.layout3Button.image = layout3Image
        
        self.leadUpWidhtConstraint.constant = 280
        self.trailUpWidthConstraint.constant = 0
        
    }

    @IBAction func layout2ImageTapped(_ sender: UITapGestureRecognizer) {
        self.gridView.layoutType = .layout2
        self.layout1Button.image = layout1Image
        self.layout2Button.image = selectedLayout
        self.layout3Button.image = layout3Image
        
        self.leadUpWidhtConstraint.constant = 135
        self.trailUpWidthConstraint.constant = 135
    }

    @IBAction func layout3ImageTapped(_ sender: UITapGestureRecognizer) {
        self.gridView.layoutType = .layout3
        self.layout1Button.image = layout1Image
        self.layout2Button.image = layout2Image
        self.layout3Button.image = selectedLayout
    }

}


