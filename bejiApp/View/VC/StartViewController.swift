//
//  StartViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation
import UIKit

final class StartViewController: UIViewController {
    let baseView: UIView = .init()
    let titleLabel: UILabel = .init()
    let button: UIButton = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @objc func tapButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "start", sender: nil)
        
    }
}

extension StartViewController {
    func setUp(){
        self.view.addSubview(baseView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(button)
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        baseView.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "背景2"))
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        titleLabel.text = "オシャベジタブル"
        titleLabel.font = .boldSystemFont(ofSize: 26)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 218),
            button.heightAnchor.constraint(equalToConstant: 74),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 200)
        ])
        button.setImage(UIImage(imageLiteralResourceName: "button"), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
    }
    
}
