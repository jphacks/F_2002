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
    let baseView: UIView = .init()
    let plantImageView: UIImageView = .init()
    var type: BejiType = .ichigo
    var viewdata: Viewdata!
    
    let button: UIButton = .init()
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
        
        
        button.setImage(UIImage(imageLiteralResourceName: "育てる"), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton1(_ :)),for: .touchUpInside)
        baseView.backgroundColor = UIColor(patternImage: viewdata.type.purchaceImage())
    }
    @objc func tapButton1(_ sender: UIButton){
        print("tap")
        purchacePlant(data: viewdata)
        self.performSegue(withIdentifier: "toPlants", sender: type)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let type = sender as! BejiType
        if segue.identifier == "toPlants" {
            let nextVC = segue.destination as! PlantViewController
            nextVC.viewdata = viewdata
        }
    }
    func purchacePlant(data: Viewdata){
        guard let token = data.token else {
            fatalError()
        }
//        let parameters: [String : Any]? = [
//            "plant_id": data.type.id(),
//        ]
        let parameters: [String : Any]? = [
                    "plant_id": 1,
                    "nick_name": "じゃがーくん2世"
                ]
        let header: HTTPHeaders? = ["Authentication": token]
        print()
        let url = "https://e3c902a3-9f7d-4f1c-9b9a-daa5e4633165.mock.pstmn.io/user/cultivations"
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:
                    header ).responseJSON {  response  in
                        print("res\(response)")
                        guard let data = response.data else { return }
                        print(data)
                        let user = try! JSONDecoder().decode(NewModel.self, from: data)
                        print("植物購入\(user)")
        }
    }
}
