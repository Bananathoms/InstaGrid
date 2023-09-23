//
//  ViewController.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 19/09/2023.
//

import UIKit

class InstagridViewController: UIViewController {
    

    @IBOutlet weak var gridView: GridView!
    
    @IBOutlet weak var layout1Button: UIImageView!
    
    @IBOutlet weak var layout2Button: UIImageView!
    
    @IBOutlet weak var layout3Button: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func layout1ImageTapped(_ sender: UITapGestureRecognizer) {
        gridView.layoutType = .layout1
    }

    @IBAction func layout2ImageTapped(_ sender: UITapGestureRecognizer) {
        gridView.layoutType = .layout2
    }

    @IBAction func layout3ImageTapped(_ sender: UITapGestureRecognizer) {
        gridView.layoutType = .layout3
    }

}

