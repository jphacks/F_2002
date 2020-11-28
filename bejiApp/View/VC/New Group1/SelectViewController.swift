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
    private let potatoButton: UIButton = .init()
    private let onionButton: UIButton = .init()
    private let carrotButton: UIButton = .init()
    private let strawberryButton: UIButton = .init()
    private let eggplantsButton: UIButton = .init()
    private let cucamberButton: UIButton = .init()
    private let baseView: UIView = .init()
    var viewdata = Viewdata()
    private let leftStackView: UIStackView = {
        let view: UIStackView = .init()
        view.alignment = .leading
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 22
        return view
    }()
    
    private let rightStackView: UIStackView =  {
        let view: UIStackView = .init()
        view.alignment = .center
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 22
        return view
    }()
    private let bigStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.addBackground(image: R.image.backGround.nomalBackground()! )
        setUp()
        self.navigationItem.titleView = UIImageView(image: R.image.plate.selectPlantsPlate())
    }
    @objc func onTapPotatoButton(_ sender: UIButton){
        self.viewdata.type = .jyagaimo
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
//        test(data: viewdata)
    }
    @objc func onTapOnionButton(_ sender: UIButton){
        self.viewdata.type = .tamanegi
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
        
    }
    @objc func onTapCarrotButton(_ sender: UIButton){
        self.viewdata.type = .ninjin
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
    }
    @objc func onTapStraberryButton(_ sender: UIButton){
        self.viewdata.type = .ichigo
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
        
    }
    @objc func onTapEggplantsButton(_ sender: UIButton){
        self.viewdata.type = .nasu
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
    }
    @objc func onTapCucumberButton(_ sender: UIButton){
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
        baseView.addSubview(bigStackView)
        bigStackView.addArrangedSubview(leftStackView)
        bigStackView.addArrangedSubview(rightStackView)
        bigStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.addArrangedSubview(potatoButton)
        leftStackView.addArrangedSubview(onionButton)
        leftStackView.addArrangedSubview(carrotButton)
        potatoButton.translatesAutoresizingMaskIntoConstraints = false
        onionButton.translatesAutoresizingMaskIntoConstraints = false
        carrotButton.translatesAutoresizingMaskIntoConstraints = false
         
        
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.addArrangedSubview(strawberryButton)
        rightStackView.addArrangedSubview(eggplantsButton)
        rightStackView.addArrangedSubview(cucamberButton)
        strawberryButton.translatesAutoresizingMaskIntoConstraints = false
        eggplantsButton.translatesAutoresizingMaskIntoConstraints = false
        cucamberButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bigStackView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            bigStackView.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor)
        
        ])
        
        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 46),
//            stackView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 174),
            leftStackView.widthAnchor.constraint(equalToConstant: 127 ),
            leftStackView.heightAnchor.constraint(equalToConstant: 444)
        ])
        
        NSLayoutConstraint.activate([
            potatoButton.widthAnchor.constraint(equalToConstant: 127),
            potatoButton.heightAnchor.constraint(equalToConstant: 132)
        ])
        NSLayoutConstraint.activate([
            onionButton.widthAnchor.constraint(equalToConstant: 127),
            onionButton.heightAnchor.constraint(equalToConstant: 132)
        ])
        NSLayoutConstraint.activate([
            carrotButton.widthAnchor.constraint(equalToConstant: 127),
            carrotButton.heightAnchor.constraint(equalToConstant: 132)
        ])
//
        NSLayoutConstraint.activate([
//            stackView2.leadingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 27),
//            stackView2.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 174),
            rightStackView.widthAnchor.constraint(equalToConstant: 127 ),
            rightStackView.heightAnchor.constraint(equalToConstant: 444)
        ])
        NSLayoutConstraint.activate([
            strawberryButton.widthAnchor.constraint(equalToConstant: 127),
            strawberryButton.heightAnchor.constraint(equalToConstant: 132)
        ])
        NSLayoutConstraint.activate([
            eggplantsButton.widthAnchor.constraint(equalToConstant: 127),
            eggplantsButton.heightAnchor.constraint(equalToConstant: 132)
        ])
        NSLayoutConstraint.activate([
            cucamberButton.widthAnchor.constraint(equalToConstant: 127),
            cucamberButton.heightAnchor.constraint(equalToConstant: 132)
        ])
        
        potatoButton.addTarget(self,action: #selector(self.onTapPotatoButton(_ :)),for: .touchUpInside)
        onionButton.addTarget(self,action: #selector(self.onTapOnionButton(_:)),for: .touchUpInside)
        carrotButton.addTarget(self,action: #selector(self.onTapCarrotButton(_:)),for: .touchUpInside)
        strawberryButton.addTarget(self,action: #selector(self.onTapStraberryButton(_:)),for: .touchUpInside)
        eggplantsButton.addTarget(self,action: #selector(self.onTapEggplantsButton(_:)),for: .touchUpInside)
        cucamberButton.addTarget(self,action: #selector(self.onTapCucumberButton(_:)),for: .touchUpInside)
        
        potatoButton.setImage(R.image.button.selectPotato(), for: .normal)
        onionButton.setImage(R.image.button.selectOnion(), for: .normal)
        carrotButton.setImage(R.image.button.selectCarrot(), for: .normal)
        strawberryButton.setImage(R.image.button.selectStrawberry(), for: .normal)
        eggplantsButton.setImage(R.image.button.selectEgplant(), for: .normal)
        cucamberButton.setImage(R.image.button.selectCucumber(), for: .normal)
    }
    private func test(data: Viewdata){
        guard let token = data.token else {
            fatalError()
        }
        let parameters: [String : Any]? = [
                    "plant_id": 1,
                    "nick_name": "じゃがーくん2世"
                ]
        let header: HTTPHeaders? = ["Authentication": token]
        print("tes確認\(token)")
        let url = "https://d3or1724225rbx.cloudfront.net/user/cultivations/3"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:
                    header ).responseJSON { response  in
                        switch response.result {
                            case .success(let res):
                                print("testjson\(res)")
                            case .failure(let error): print(error)
                        }
//                        print("json\(response)")
//                        guard let data = response.data else { return }
//                        print(data)
//                        let user = try! JSONDecoder().decode(NewModel.self, from: data)
//                        print("植物購入\(user)")
//                        self.button.setTitle(user.nickName, for: .normal)
//                        self.button.backgroundColor = .red
                        
        }
    }
}
