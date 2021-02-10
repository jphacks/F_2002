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
            print("登録")
        }
    }
}
