//
//  PurchaceViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit

class PurchaceViewController: UIViewController {

    let button: UIButton = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 218),
            button.heightAnchor.constraint(equalToConstant: 74),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        button.setTitle("購入", for: .normal)
        button.addTarget(self,action: #selector(self.tapButton1(_ :)),for: .touchUpInside)
        button.backgroundColor = .red
       
    }
    @objc func tapButton1(_ sender: UIButton){
        self.performSegue(withIdentifier: "toJag", sender: nil)
    }
    

}
