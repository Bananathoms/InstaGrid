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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func layout1ImageTapped(_ sender: UITapGestureRecognizer) {
        self.gridView.layoutType = .layout1
        self.layout1Button.image = selectedLayout
        self.layout2Button.image = layout2Image
        self.layout3Button.image = layout3Image
    }

    @IBAction func layout2ImageTapped(_ sender: UITapGestureRecognizer) {
        self.gridView.layoutType = .layout2
        self.layout1Button.image = layout1Image
        self.layout2Button.image = selectedLayout
        self.layout3Button.image = layout3Image
    }

    @IBAction func layout3ImageTapped(_ sender: UITapGestureRecognizer) {
        self.gridView.layoutType = .layout3
        self.layout1Button.image = layout1Image
        self.layout2Button.image = layout2Image
        self.layout3Button.image = selectedLayout
    }

}

