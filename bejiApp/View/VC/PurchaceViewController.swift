//
//  PurchaceViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit

class PurchaceViewController: UIViewController {
    let baseView: UIView = .init()
    let plantImageView: UIImageView = .init()

    let button: UIButton = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 352),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -45)
        ])

        button.setImage(UIImage(imageLiteralResourceName: "育てる"), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton1(_ :)),for: .touchUpInside)
       
    }
    @objc func tapButton1(_ sender: UIButton){
        self.performSegue(withIdentifier: "toPlants", sender: nil)
    }
    

}
