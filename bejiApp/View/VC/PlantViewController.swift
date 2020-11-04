//
//  PlantViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit

class PlantViewController: UIViewController {
    let commentView: CustomView = .init()
    let commentLabel: UILabel = .init()
    let chatButton: CustomCircleView = .init()
    let dayLabel: UILabel = .init()
    let iotButton: UIButton = .init()
    let baseView: UIView = .init()
    
     override func viewDidLoad() {
        super.viewDidLoad()
       setUp()
    }
    
}
extension PlantViewController {
    func setUp(){
        self.view.addSubview(baseView)
        baseView.addSubview(commentView)
        baseView.addSubview(chatButton)
        baseView.addSubview(iotButton)
        baseView.addSubview(dayLabel)
        commentView.addSubview(commentLabel)
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        iotButton.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        commentView.translatesAutoresizingMaskIntoConstraints = false
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 144),
            commentView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 46),
            commentView.widthAnchor.constraint(equalToConstant: 326),
            commentView.heightAnchor.constraint(equalToConstant: 140)
        ])
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: commentView.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor),
            commentLabel.topAnchor.constraint(equalTo: commentView.topAnchor),
            commentLabel.bottomAnchor.constraint(equalTo: commentView.bottomAnchor)
        ])
        commentLabel.text = "これからの成長が楽しみだっもん！"
        commentLabel.font = .boldSystemFont(ofSize: 25)
        commentLabel.textColor = .black
        commentLabel.clipsToBounds = true

        commentLabel.numberOfLines = 0
        commentLabel.backgroundColor = .white
        commentLabel.textAlignment = .center
        commentLabel.clipsToBounds = true
        commentLabel.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 44),
            dayLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 99),
            dayLabel.widthAnchor.constraint(equalToConstant: 101),
            dayLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        dayLabel.backgroundColor = .clear
        dayLabel.text = "栽培1日目"
        dayLabel.font = .boldSystemFont(ofSize: 13)
        
        NSLayoutConstraint.activate([
            chatButton.centerXAnchor.constraint(equalTo: commentView.trailingAnchor),
            chatButton.centerYAnchor.constraint(equalTo: commentView.topAnchor),
            chatButton.widthAnchor.constraint(equalToConstant: 82),
            chatButton.heightAnchor.constraint(equalToConstant: 82)
        ])
        chatButton.layer.cornerRadius = 41
        chatButton.backgroundColor = .red
        
       
        baseView.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "背景"))
        chatButton.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
      
        
    }
    @objc func tapButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toChat", sender: nil)
    }
}
