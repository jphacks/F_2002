//
//  SelectViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Firebase
import Alamofire
//stackviewの調整面倒なので脳死作成、後で書き直す

final class SelectViewController: UIViewController {
    var idtoken: String = .init()
    private let button1: UIButton = .init()
    private let button2: UIButton = .init()
    private let button3: UIButton = .init()
    private let button4: UIButton = .init()
    private let button5: UIButton = .init()
    private let button6: UIButton = .init()
    private let baseView: UIView = .init()
    var viewdata = Viewdata()
    private let stackView: UIStackView = {
        let view: UIStackView = .init()
        view.alignment = .leading
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 22
        return view
    }()
    
    private let stackView2: UIStackView =  {
        let view: UIStackView = .init()
        view.alignment = .center
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 22
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewdata.token = idtoken
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "タネを選ぼう"))
    }
    
    @objc func tapButton1(_ sender: UIButton){
        self.viewdata.type = .jyagaimo
        guard let token = viewdata.token else {fatalError()
        }
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
    }
    @objc func tapButton2(_ sender: UIButton){
        self.viewdata.type = .tamanegi
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
        
    }
    @objc func tapButton3(_ sender: UIButton){
        self.viewdata.type = .ninjin
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
    }
    @objc func tapButton4(_ sender: UIButton){
        self.viewdata.type = .ichigo
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
        
    }
    @objc func tapButton5(_ sender: UIButton){
        self.viewdata.type = .nasu
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
    }
    @objc func tapButton6(_ sender: UIButton){
        self.viewdata.type = .kyuuri
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPurchace" {
            let nextVC = segue.destination as! PurchaceViewController
            nextVC.viewdata = self.viewdata
        }
    }
}
extension SelectViewController {
    private func setUp(){
        self.navigationItem.hidesBackButton = true
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
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 46),
            stackView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 174),
            stackView.widthAnchor.constraint(equalToConstant: 127 ),
            stackView.heightAnchor.constraint(equalToConstant: 444)
        ])
        
        NSLayoutConstraint.activate([
            button1.widthAnchor.constraint(equalToConstant: 127),
            button1.heightAnchor.constraint(equalToConstant: 132)
        ])
        NSLayoutConstraint.activate([
            button2.widthAnchor.constraint(equalToConstant: 127),
            button2.heightAnchor.constraint(equalToConstant: 132)
        ])
        NSLayoutConstraint.activate([
            button3.widthAnchor.constraint(equalToConstant: 127),
            button3.heightAnchor.constraint(equalToConstant: 132)
        ])
        
        NSLayoutConstraint.activate([
            stackView2.leadingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 27),
            stackView2.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 174),
            stackView2.widthAnchor.constraint(equalToConstant: 127 ),
            stackView2.heightAnchor.constraint(equalToConstant: 444)
        ])
        NSLayoutConstraint.activate([
            button4.widthAnchor.constraint(equalToConstant: 127),
            button4.heightAnchor.constraint(equalToConstant: 132)
        ])
        NSLayoutConstraint.activate([
            button5.widthAnchor.constraint(equalToConstant: 127),
            button5.heightAnchor.constraint(equalToConstant: 132)
        ])
        NSLayoutConstraint.activate([
            button6.widthAnchor.constraint(equalToConstant: 127),
            button6.heightAnchor.constraint(equalToConstant: 132)
        ])
        
        button1.addTarget(self,action: #selector(self.tapButton1(_ :)),for: .touchUpInside)
        button2.addTarget(self,action: #selector(self.tapButton2(_ :)),for: .touchUpInside)
        button3.addTarget(self,action: #selector(self.tapButton3(_ :)),for: .touchUpInside)
        button4.addTarget(self,action: #selector(self.tapButton4(_ :)),for: .touchUpInside)
        button5.addTarget(self,action: #selector(self.tapButton5(_ :)),for: .touchUpInside)
        button6.addTarget(self,action: #selector(self.tapButton6(_ :)),for: .touchUpInside)
        
        button1.setImage(UIImage(imageLiteralResourceName: "potato"), for: .normal)
        button2.setImage(UIImage(imageLiteralResourceName: "onion"), for: .normal)
        button3.setImage(UIImage(imageLiteralResourceName: "carot"), for: .normal)
        button4.setImage(UIImage(imageLiteralResourceName: "Strawberry"), for: .normal)
        button5.setImage(UIImage(imageLiteralResourceName: "egplant"), for: .normal)
        button6.setImage(UIImage(imageLiteralResourceName: "cucumber"), for: .normal)
        
        baseView.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "background"))
    }
}
