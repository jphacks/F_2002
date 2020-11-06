//
//  SelectViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Firebase
//stackviewの調整面倒なので脳死作成、後で書き直す

class SelectViewController: UIViewController {
    
    var path: Auth!
    var idtoken:String = .init()
    let button1: UIButton = .init()
    let button2: UIButton = .init()
    let button3: UIButton = .init()
    let button4: UIButton = .init()
    let button5: UIButton = .init()
    let button6: UIButton = .init()
    let baseView: UIView = .init()
    
    let stackView: UIStackView = {
        let view: UIStackView = .init()
        view.alignment = .leading
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 26
        return view
    }()
    
    let stackView2: UIStackView =  {
        let view: UIStackView = .init()
        view.alignment = .center
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 26
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        print(path)
        self.path.currentUser?.getIDTokenForcingRefresh(true){ idToken, error in
            if let error = error {
              print("tokenerror")
              return;
            }
            print("token\(idToken)")
            guard let token = idToken else {fatalError()}
            self.idtoken = token
            print("OK?token\(idToken)")

           
          }
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "タネを選ぼう"))

    }
    
    @objc func tapButton1(_ sender: UIButton){
        let type: BejiType = .jyagaimo
        self.performSegue(withIdentifier: "toPurchace", sender: type)
        print("tap")
    }
    @objc func tapButton2(_ sender: UIButton){
        let type: BejiType = .tamanegi
        self.performSegue(withIdentifier: "toPurchace", sender: type)
        
    }
    @objc func tapButton3(_ sender: UIButton){
        let type: BejiType = .ninjin
        self.performSegue(withIdentifier: "toPurchace", sender: type)
    }
    @objc func tapButton4(_ sender: UIButton){
        let type: BejiType = .ichigo
        self.performSegue(withIdentifier: "toPurchace", sender: type)
        
    }
    @objc func tapButton5(_ sender: UIButton){
        let type: BejiType = .nasu
        self.performSegue(withIdentifier: "toPurchace", sender: type)
    }
    @objc func tapButton6(_ sender: UIButton){
        let type: BejiType = .kyuuri
        self.performSegue(withIdentifier: "toPurchace", sender: type)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let type = sender as! BejiType
        if segue.identifier == "toPurchace" {
            let nextVC = segue.destination as! PurchaceViewController
            nextVC.type = type
            
        }
    }
    
}
extension SelectViewController {
    func setUp(){
        self.view.addSubview(baseView)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        baseView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        baseView.addSubview(stackView2)
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.addArrangedSubview(button4)
        stackView2.addArrangedSubview(button5)
        stackView2.addArrangedSubview(button6)
        button4.translatesAutoresizingMaskIntoConstraints = false
        button5.translatesAutoresizingMaskIntoConstraints = false
        button6.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
            stackView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 180),
            stackView.widthAnchor.constraint(equalToConstant: 147 ),
            stackView.heightAnchor.constraint(equalToConstant: 512)
        ])
        
        NSLayoutConstraint.activate([
            button1.widthAnchor.constraint(equalToConstant: 147),
            button1.heightAnchor.constraint(equalToConstant: 153)
        ])
        NSLayoutConstraint.activate([
            button2.widthAnchor.constraint(equalToConstant: 147),
            button2.heightAnchor.constraint(equalToConstant: 153)
        ])
        NSLayoutConstraint.activate([
            button3.widthAnchor.constraint(equalToConstant: 147),
            button3.heightAnchor.constraint(equalToConstant: 153)
        ])
        
        NSLayoutConstraint.activate([
            stackView2.leadingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 33),
            stackView2.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 180),
            stackView2.widthAnchor.constraint(equalToConstant: 147 ),
            stackView2.heightAnchor.constraint(equalToConstant: 512)
        ])
        NSLayoutConstraint.activate([
            button4.widthAnchor.constraint(equalToConstant: 147),
            button4.heightAnchor.constraint(equalToConstant: 153)
        ])
        NSLayoutConstraint.activate([
            button5.widthAnchor.constraint(equalToConstant: 147),
            button5.heightAnchor.constraint(equalToConstant: 153)
        ])
        NSLayoutConstraint.activate([
            button6.widthAnchor.constraint(equalToConstant: 147),
            button6.heightAnchor.constraint(equalToConstant: 153)
        ])
        
        button1.addTarget(self,action: #selector(self.tapButton1(_ :)),for: .touchUpInside)
        button2.addTarget(self,action: #selector(self.tapButton2(_ :)),for: .touchUpInside)
        button3.addTarget(self,action: #selector(self.tapButton3(_ :)),for: .touchUpInside)
        button4.addTarget(self,action: #selector(self.tapButton4(_ :)),for: .touchUpInside)
        button5.addTarget(self,action: #selector(self.tapButton5(_ :)),for: .touchUpInside)
        button6.addTarget(self,action: #selector(self.tapButton6(_ :)),for: .touchUpInside)
        
        button1.setImage(UIImage(imageLiteralResourceName: "じゃがいも"), for: .normal)
        button2.setImage(UIImage(imageLiteralResourceName: "タマネギ"), for: .normal)
        button3.setImage(UIImage(imageLiteralResourceName: "にんじん"), for: .normal)
        button4.setImage(UIImage(imageLiteralResourceName: "いちご"), for: .normal)
        button5.setImage(UIImage(imageLiteralResourceName: "なす"), for: .normal)
        button6.setImage(UIImage(imageLiteralResourceName: "きゅうり"), for: .normal)
        
        baseView.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "背景1"))
    }
}
