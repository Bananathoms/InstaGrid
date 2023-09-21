//
//  ViewController.swift
//  InstaGrid
//
//  Created by Thomas Carlier on 17/09/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let gridView = GridView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        
        let label = UILabel()
        label.text = "Instagrid"
        label.font = UIFont(name: "ThirstySoftRegular", size: 30)
        label.textColor = UIColor.white
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        
         let swipeMessageLabel = UILabel()
         swipeMessageLabel.text = "Swipe up to share"
         swipeMessageLabel.font = UIFont.systemFont(ofSize: 16)
         swipeMessageLabel.textColor = UIColor.white
         
         let chevronImageView = UIImageView(image: UIImage(named: "chevron_up"))
         
         view.addSubview(swipeMessageLabel)
         view.addSubview(chevronImageView)
         
         swipeMessageLabel.translatesAutoresizingMaskIntoConstraints = false
         chevronImageView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             swipeMessageLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
             swipeMessageLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
             
             chevronImageView.topAnchor.constraint(equalTo: swipeMessageLabel.bottomAnchor, constant: 10),
             chevronImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
         ])

        view.addSubview(gridView)
        
        gridView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gridView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gridView.widthAnchor.constraint(equalToConstant: 300),
            gridView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        let layoutButton1 = UIButton()
        layoutButton1.setTitle("Layout 1", for: .normal)
        layoutButton1.addTarget(self, action: #selector(layoutButtonTapped(sender:)), for: .touchUpInside)
        layoutButton1.tag = 1// Associez un tag pour identifier le cas de l'enum

        let layoutButton2 = UIButton()
        layoutButton2.setTitle("Layout 2", for: .normal)
        layoutButton2.addTarget(self, action: #selector(layoutButtonTapped(sender:)), for: .touchUpInside)
        layoutButton2.tag = 2

        let layoutButton3 = UIButton()
        layoutButton3.setTitle("Layout 3", for: .normal)
        layoutButton3.addTarget(self, action: #selector(layoutButtonTapped(sender:)), for: .touchUpInside)
        layoutButton3.tag = 3

        view.addSubview(layoutButton1)
        view.addSubview(layoutButton2)
        view.addSubview(layoutButton3)

        layoutButton1.translatesAutoresizingMaskIntoConstraints = false
        layoutButton2.translatesAutoresizingMaskIntoConstraints = false
        layoutButton3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            layoutButton1.topAnchor.constraint(equalTo: gridView.bottomAnchor, constant: 20),
            layoutButton1.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            layoutButton2.topAnchor.constraint(equalTo: layoutButton1.bottomAnchor, constant: 10),
            layoutButton2.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            layoutButton3.topAnchor.constraint(equalTo: layoutButton2.bottomAnchor, constant: 10),
            layoutButton3.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])
    
    }

    @objc func layoutButtonTapped(sender: UIButton) {
        guard let layoutType = LayoutType(rawValue: sender.tag) else {
            return
        }
        gridView.layoutType = layoutType
    }
}




