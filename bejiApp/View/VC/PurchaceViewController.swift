//
//  PurchaceViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit

//API実装：植物選択購入

class PurchaceViewController: UIViewController {
    let baseView: UIView = .init()
    let plantImageView: UIImageView = .init()
    var type: BejiType = .ichigo

    let button: UIButton = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: type.nameImage())
        self.view.addSubview(baseView)
        baseView.addSubview(button)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 352),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -45)
        ])
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])


        button.setImage(UIImage(imageLiteralResourceName: "育てる"), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton1(_ :)),for: .touchUpInside)
//        baseView.backgroundColor = UIColor(patternImage: type.purchaceImage())
    }
    @objc func tapButton1(_ sender: UIButton){
        self.performSegue(withIdentifier: "toPlants", sender: type)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let type = sender as! BejiType
        if segue.identifier == "toPlants" {
            let nextVC = segue.destination as! PlantViewController
            nextVC.type = self.type
            
        }
    }
    

}
