//
//  StartViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation
import UIKit
import Alamofire

final class StartViewController: UIViewController {
    let baseView: UIView = .init()
    let logo: UIImageView = .init()
    let button: UIButton = .init()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @objc func tapButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toSignUp", sender: nil)
    }
}

extension StartViewController {
    func setUp(){
        self.view.addSubview(baseView)
        self.view.addSubview(logo)
        self.view.addSubview(button)
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        baseView.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "background"))
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 183),
            logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        logo.image = UIImage(imageLiteralResourceName: "logo")
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 183),
            button.heightAnchor.constraint(equalToConstant: 62),
            button.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 157)
        ])
        button.setImage(UIImage(imageLiteralResourceName: "startButton"), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
    }
}


extension StartViewController {
    //全植物を取得
}
