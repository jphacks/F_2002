//
//  SignUpViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Firebase
import Alamofire

final class SignUpViewController: UIViewController {
    private let baseView: UIView = .init()
    private let mailTextField: UITextField = .init()
    private let passTextField:UITextField = .init()
    private let button: UIButton = .init()
    var idToken: String = .init()
    var auth:Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        auth = Auth.auth()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelect" {
            let nextVC = segue.destination as! SelectViewController
            nextVC.idtoken = self.idToken
        }
    }
    //タップ時に入力欄問題なければidToken取得後サーバーに登録して画面遷移
    @objc func tapButton(_ sender: UIButton){
        if mailTextField.text?.count != 0 && passTextField.text?.count != 0 {
            guard let mail = mailTextField.text else {fatalError()}
            guard let pass = passTextField.text else {fatalError()}
            getIdToken(mail: mail, pass: pass)
        }
    }
    //idtoken取得
    private func getIdToken(mail: String, pass: String) {
        auth.createUser(withEmail: mail, password: pass) { (result, error) in
            if error == nil, let result = result {
                result.user.sendEmailVerification(completion: { (error) in
                    if error == nil {
                        self.auth.currentUser?.getIDTokenForcingRefresh(true){ idToken, error in
                            if error != nil { return }
                            guard let token = idToken else {fatalError()}
                            self.performSegue(withIdentifier: "toSelect", sender: self.idToken)
                            self.registerUser(idtoken: token)
                        }
                    }
                })
            }
        }
    }
    //idtokenをサーバーに登録
    private func registerUser(idtoken: String) {
        let header: HTTPHeaders? = ["Authorization": idtoken]
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

extension SignUpViewController {
    private func setUp(){
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "ログインしよう"))
        self.view.addSubview(baseView)
        baseView.addSubview(mailTextField)
        baseView.addSubview(passTextField)
        baseView.addSubview(button)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        baseView.backgroundColor = UIColor(patternImage: R.image.backGround.nomalBackground()!)
        
        
        NSLayoutConstraint.activate([
            mailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mailTextField.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 258),
            mailTextField.widthAnchor.constraint(equalToConstant: 286),
            mailTextField.heightAnchor.constraint(equalToConstant: 46)
        ])
        mailTextField.backgroundColor = UIColor(hex: "E4EFDD")
        mailTextField.clipsToBounds = true
        mailTextField.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        paddingView.backgroundColor = .clear
        mailTextField.leftView = paddingView
        mailTextField.leftViewMode = .always
        mailTextField.attributedPlaceholder = NSAttributedString(string: "メールアドレス", attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: "658350")])
        
        
        NSLayoutConstraint.activate([
            passTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor
                                               , constant: 20),
            passTextField.widthAnchor.constraint(equalToConstant: 286),
            passTextField.heightAnchor.constraint(equalToConstant: 46)
        ])
        passTextField.backgroundColor = UIColor(hex: "E4EFDD")
        passTextField.clipsToBounds = true
        passTextField.layer.cornerRadius = 8
        passTextField.attributedPlaceholder = NSAttributedString(string: "パスワード", attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: "658350")])
        let passPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        passPaddingView.backgroundColor = .clear
        passTextField.leftView = passPaddingView
        passTextField.leftViewMode = .always
        
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 88),
            button.widthAnchor.constraint(equalToConstant: 285),
            button.heightAnchor.constraint(equalToConstant: 49)
        ])
        button.setImage(R.image.button.loginButton(), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
    }
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
