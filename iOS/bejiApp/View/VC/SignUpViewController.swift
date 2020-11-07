//
//  SignUpViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Firebase
import Alamofire

class SignUpViewController: UIViewController {
    
    var auth:Auth!
    let baseView: UIView = .init()
    let mailTextField: UITextField = .init()
    let passTextField:UITextField = .init()
    let button: UIButton = .init()
    var idToken: String = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        auth = Auth.auth()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let type = sender as! BejiType
        if segue.identifier == "toSelect" {
            let nextVC = segue.destination as! SelectViewController
            nextVC.idtoken = self.idToken
            
        }
    }
    
    @objc func tapButton(_ sender: UIButton){
        
        if mailTextField.text?.count == 0 && passTextField.text?.count != 0{
            print("メールなし")
        }
        if passTextField.text?.count == 0  && mailTextField.text?.count != 0{
            print("パスなし")
        }
        if passTextField.text?.count == 0 && mailTextField.text?.count == 0 {
            print("二つなし")
        }
        if mailTextField.text?.count != 0 && passTextField.text?.count != 0 {
            //            self.performSegue(withIdentifier: "toSelect", sender: auth)
        }
        guard let mail = mailTextField.text else {fatalError()}
        guard let pass = passTextField.text else {fatalError()}
//        auth.createUser(withEmail: mail, password: pass) { (result, error) in
//            if error == nil, let result = result {result.user.sendEmailVerification(completion: { (error) in
//                if error == nil {
//                    self.auth.currentUser?.getIDTokenForcingRefresh(true){ idToken, error in
//                        if let error = error {
//                            // Handle error
//                            return;
//                        }
//                        guard let token = idToken else {fatalError()}
//                        print("token\(token)")
//                        self.idToken = token
        self.idToken = "a"
                    self.performSegue(withIdentifier: "toSelect", sender: self.idToken)
//                        self.registerUser(idtoken: token)
                    }
                
//            })
//        )
//            }
//        }
//    }
    func registerUser(idtoken: String) {
        let header: HTTPHeaders? = ["Authorization": idtoken]
        let url = "https://d3or1724225rbx.cloudfront.net/users"
        let parameters: [String : Any]? = [
            "name": "こんにゃく"
                ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:
                    header ).responseJSON {  response  in
                        print("res\(response)")
                        guard let data = response.data else { return }
                        print("data\(data)")
                        let user = try! JSONDecoder().decode(UserModel.self, from: data)
                        print("user\(user)")
                    }
    }
    func getUser(idtoken: String){
        let header: HTTPHeaders? = ["Authorization": idtoken]
        let url = "https://d3or1724225rbx.cloudfront.net/user"
        let parameters: [String : Any]? = [
            "name": "あああ"
        ]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:
                    header ).responseJSON {  response  in
                        print("res\(response)")
                        guard let data = response.data else { return }
                        print("data\(data)")
                        let user = try! JSONDecoder().decode(UserModel.self, from: data)
                        print("user\(user)")
                    }
    }
    
}

extension SignUpViewController {
    func setUp(){
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
        
        baseView.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "background"))
        
        
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
        button.setImage(UIImage(imageLiteralResourceName: "loginButton"), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
    }
}
