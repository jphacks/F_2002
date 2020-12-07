//
//  PurchaceModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/05.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Alamofire
import Firebase

// private func purchacePlant(data: CommonData){
//guard let token = data.token else {
//    fatalError()
//}
//let parameters: [String : Any]? = [
//            "plant_id": 1,
//            "nick_name": "じゃがーくん2世"
//        ]
//let header: HTTPHeaders? = ["Authorization": token]
//print("確認\(token)")
//let url = "https://d3or1724225rbx.cloudfront.net/user/cultivations"
//AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:
//            header ).responseJSON { response  in
//                switch response.result {
//                    case .success(let res):
//                        print("json\(res)")
//
//                    case .failure(let error): print(error)
//                }
//                print("json\(response)")
//                guard let data = response.data else { return }
//                print(data)
//                let user = try! JSONDecoder().decode(CultivationIdModel.self, from: data)
//                print(user)
////                        let user = try! JSONDecoder().decode(NewModel.self, from: data)
////                        print("植物購入\(user)")
//}
//}
protocol PurchaceModelProtocol {
    func purchacePlant(data: CommonData)
}


