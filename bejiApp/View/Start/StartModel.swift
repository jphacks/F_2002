//
//  StartModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Alamofire
import Firebase

protocol StartModelProtocol {
    func signInAnonymously() -> Observable<CommonData>
    func registerUser(idtoken: String, api: API )
}

class StartModel: StartModelProtocol {
    var auth: Auth?
    init() {
        auth = Auth.auth()
    }
    func signInAnonymously() -> Observable<CommonData> {
        return Observable.create{ [self] observer in
            var data: CommonData = .init()
            self.auth?.signInAnonymously() { authResult, error in
                guard let user = authResult?.user else { return }
                user.getIDToken() { token, error in
                    guard let userToken = token else { return }
                    print("sign\(userToken)")
                    data.token = userToken
                    data.uid = user.uid
                    self.registerUser(idtoken: userToken, api: .users )
                    data.token?.postUserDefaults(key: "token")
                    data.uid?.postUserDefaults(key: "uid")
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    func registerUser(idtoken: String, api: API ) {
        let header: HTTPHeaders? = ["Authorization": idtoken]
        let url = api.path
        let parameters: [String: Any]? = ["name": "こんにゃく" ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header ).responseJSON { response  in
            guard let data = response.data else { return }
//            let user = try! JSONDecoder().decode(UserModel.self, from: data)
            print("response: \(response)")
            print("data: \(data)")
//            print("user: \(String(describing: user))")
        }
    }
    
//    func purchacePlants(data: CommonData) {
//        guard let token = data.token else {
//            fatalError("notToken")
//        }
//        let parameters: [String: Any]? = [
//            "plant_id": 1,
//            "nick_name": "じゃがーくん2世"
//        ]
//        let header: HTTPHeaders? = ["Authentication": token]
//        print("tes確認\(token)")
//        let url = "https://d3or1724225rbx.cloudfront.net/user/cultivations/3"
//        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:
//                    header ).responseJSON { response  in
//                        switch response.result {
//                            case .success(let res):
//                                print("testjson\(res)")
//                            case .failure(let error):
//                                print(error)
//                        }
//                    }
//    }
//    private func purchacePlant(data: CommonData){
//        guard let token = data.token else {
//            fatalError()
//        }
//        let parameters: [String : Any]? = [
//            "plant_id": 1,
//            "nick_name": "じゃがーくん2世"
//        ]
//        let header: HTTPHeaders? = ["Authorization": token]
//        let url = "https://d3or1724225rbx.cloudfront.net/user/cultivations"
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:
//                    header ).responseJSON { response  in
//                        switch response.result {
//                            case .success(let res):
//                                print("json\(res)")
//
//                            case .failure(let error): print(error)
//                        }
//                        print("json\(response)")
//                        guard let data = response.data else { return }
//                        print(data)
//                        let user = try? JSONDecoder().decode(CultivationIdModel.self, from: data)
//                        print(user)
//                    }
//    }
}
