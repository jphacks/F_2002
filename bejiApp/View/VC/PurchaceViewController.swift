//
//  PurchaceViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Alamofire

//API実装：植物選択購入
class PurchaceViewController: UIViewController {
    private let baseView: UIView = .init()
    private let plantImageView: UIImageView = .init()
    var type: BejiMock = .ichigo
    var viewdata: Viewdata!
    
    override func loadView() {
        super.loadView()
    }
    
    private let button: UIButton = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: viewdata.type.nameImage())
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
        
//        button.setTitle("", for: .normal)
//        button.setImage(UIImage(imageLiteralResourceName: "育てる"), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton1(_ :)),for: .touchUpInside)
        baseView.backgroundColor = UIColor(patternImage: viewdata.type.purchaceImage())
    }
    @objc func tapButton1(_ sender: UIButton){
        purchacePlant(data: viewdata)
        self.performSegue(withIdentifier: "toPlants", sender: type)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let type = sender as! BejiMock
        if segue.identifier == "toPlants" {
            let nextVC = segue.destination as! PlantViewController
            nextVC.viewdata = viewdata
        }
    }
    //サーバーに購入データ登録後植物データ取得
    private func purchacePlant(data: Viewdata){
        guard let token = data.token else {
            fatalError()
        }
        let parameters: [String : Any]? = [
                    "plant_id": 1,
                    "nick_name": "じゃがーくん2世"
                ]
        let header: HTTPHeaders? = ["Authentication": token]
        let url = "https://d3or1724225rbx.cloudfront.net/user/cultivations"
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:
                    header ).responseJSON { response  in
                        switch response.result {
                            case .success(let res):
                                print("json\(res)")
//                                print(JSON(res))
//                                guard let data = (response as AnyObject).data else { return }
//                                print(data)
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
