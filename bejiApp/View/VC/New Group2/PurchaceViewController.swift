//
//  PurchaceViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Alamofire

//API実装：植物選択購入
final class PurchaceViewController: UIViewController {
    private let baseView: UIView = .init()
    private let plantImageView: UIImageView = .init()
    var type: BejiMock = .ichigo
    private let button: UIButton = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
       setUp()
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
    private func purchacePlant(data: CommonData){
        guard let token = data.token else {
            fatalError()
        }
        let parameters: [String : Any]? = [
                    "plant_id": 1,
                    "nick_name": "じゃがーくん2世"
                ]
        let header: HTTPHeaders? = ["Authorization": token]
        print("確認\(token)")
        let url = "https://d3or1724225rbx.cloudfront.net/user/cultivations"
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:
                    header ).responseJSON { response  in
                        switch response.result {
                            case .success(let res):
                                print("json\(res)")
                                
                            case .failure(let error): print(error)
                        }
                        print("json\(response)")
                        guard let data = response.data else { return }
                        print(data)
                        let user = try! JSONDecoder().decode(CultivationIdModel.self, from: data)
                        print(user)
//                        let user = try! JSONDecoder().decode(NewModel.self, from: data)
//                        print("植物購入\(user)")
        }
    }
}
extension PurchaceViewController {
    func setUp(){
        self.navigationItem.titleView = UIImageView(image: viewdata.type.nameImage)
        self.view.addSubviews(baseView).activateAutoLayout()
        baseView.addSubviews(button).activateAutoLayout()
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 352),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -45)
        ])
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        button.setImage(R.image.button.growButton()!, for: .normal)
        button.addTarget(self,action: #selector(self.tapButton1(_ :)),for: .touchUpInside)
        baseView.addBackground(image: viewdata.type.purchaceImage)
    }
}
