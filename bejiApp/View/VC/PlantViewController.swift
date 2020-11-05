//
//  PlantViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit

//loading時にユーザー情報に応じた植物情報取得

class PlantViewController: UIViewController {
    let commentView: CustomView = .init()
    let commentLabel: UILabel = .init()
    let chatButton: UIButton = .init()
    let dayLabel: UILabel = .init()
    let iotButton: UIButton = .init()
    let baseView: UIView = .init()
    
    var type: BejiType = .ichigo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    func getPlantCount(day: Int){
        dayLabel.text = "栽培\(day)日目"
    }
    func getPalntComment(comment: String){
        commentLabel.text = comment
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
            commentView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 167),
            commentView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 46),
            commentView.widthAnchor.constraint(equalToConstant: 326),
            commentView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: commentView.leadingAnchor,constant: 52),
            commentLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor,constant: -40),
            commentLabel.topAnchor.constraint(equalTo: commentView.topAnchor,constant: 50),
            //            commentLabel.bottomAnchor.constraint(equalTo: commentView.bottomAnchor)
        ])
        commentLabel.text = "これからの成長が楽しみだっもん！"
        commentLabel.font = .boldSystemFont(ofSize: 20)
        commentLabel.textColor = .black
        commentLabel.clipsToBounds = true
        
        commentLabel.numberOfLines = 0
        commentLabel.backgroundColor = .white
        commentLabel.textAlignment = .center
        commentLabel.clipsToBounds = true
        commentLabel.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 44),
            dayLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 122),
            dayLabel.widthAnchor.constraint(equalToConstant: 120),
            dayLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        dayLabel.backgroundColor = .clear
        dayLabel.text = "栽培1日目"
        dayLabel.font = .boldSystemFont(ofSize: 20)
        
        NSLayoutConstraint.activate([
            chatButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 301),
            chatButton.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 118),
            chatButton.widthAnchor.constraint(equalToConstant: 82),
            chatButton.heightAnchor.constraint(equalToConstant: 82)
        ])
        chatButton.setImage(UIImage(imageLiteralResourceName: "チャットボタン"), for: .normal)
        
        NSLayoutConstraint.activate([
            iotButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 98),
            iotButton.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            iotButton.widthAnchor.constraint(equalToConstant: 215),
            iotButton.heightAnchor.constraint(equalToConstant: 215)
        ])
        iotButton.setImage(UIImage(imageLiteralResourceName:"Plant1"), for: .normal)
        
        
        baseView.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "背景２"))
        chatButton.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
    }
    @objc func tapButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toChat", sender: nil)
    }
}
