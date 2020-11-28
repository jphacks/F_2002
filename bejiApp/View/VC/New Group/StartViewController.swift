//
//  StartViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation
import UIKit
import Alamofire
import Rswift
import Firebase

final class StartViewController: UIViewController {
    let baseView: UIView = .init()
    let logo: UIImageView = .init()
    let button: UIButton = .init()
    var viewdata = Viewdata()
    var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        auth = Auth.auth()
    }
    
    @objc func tapButton(_ sender: UIButton){
        login()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelect" {
            let nextVC = segue.destination as! SelectViewController
            nextVC.viewdata = self.viewdata
        }
    }
    private func login() {
        signInAnonymously()
    }
    private func signInAnonymously(){
        auth.signInAnonymously(){
            authResult, error in
            guard let user = authResult?.user else {
                return
            }
            user.getIDToken() {
                token, error in
                guard let userToken = token else {
                    return
                }
                print("sign\(userToken)")
                self.viewdata.token = userToken
                self.viewdata.uid = user.uid
                self.performSegue(withIdentifier: "toSelect", sender: self.viewdata)
                self.registerUser(idtoken: userToken)
            }
        }
    }
    private func registerUser(idtoken: String) {
        let header: HTTPHeaders? = ["Authorization": idtoken]
        print("idt\(idtoken)")
        let url = "https://d3or1724225rbx.cloudfront.net/users"
        let parameters: [String : Any]? = [
            "name": "こんにゃく"
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:
                    header ).responseJSON { response  in
                        print("res\(response)")
                        guard let data = response.data else { return }
                        print("data\(data)")
                        let user = try! JSONDecoder().decode(UserModel.self, from: data)
                        print("user\(user)")
                    }
    }
}

extension StartViewController {
    func setUp(){
        self.view.addSubview(baseView)
        self.view.addSubview(logo)
        self.view.addSubview(button)
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
//        baseView.backgroundColor = UIColor(patternImage: R.image.backGround.nomalBackground()! )
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 183),
            logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        logo.image = R.image.logo()!
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 183),
            button.heightAnchor.constraint(equalToConstant: 62),
            button.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 157)
        ])
        button.setImage(R.image.button.startButton(), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
        baseView.addBackground(image:  R.image.backGround.nomalBackground()!)
//        baseView.backgroundColor = UIColor(patternImage:  (R.image.backGround.nomalBackground()?.resize(size: .init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 88 )))! )
    }
}
