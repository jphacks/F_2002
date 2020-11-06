//
//  SignUpViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    var auth:Auth!

    let baseView: UIView = .init()
    let mailTextField: UITextField = .init()
    let passTextField:UITextField = .init()
    let button: UIButton = .init()
    
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
            self.performSegue(withIdentifier: "toSelect", sender: nil)
        }
        guard let mail = mailTextField.text else {fatalError()}
        guard let pass = passTextField.text else {fatalError()}
        auth.createUser(withEmail: mail, password: pass) { (result, error) in
            if error == nil, let result = result {result.user.sendEmailVerification(completion: { (error) in
                if error == nil {let alert = UIAlertController(title: "仮登録を行いました。", message: "入力したメールアドレス宛に確認メールを送信しました。", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.auth.currentUser?.getIDTokenForcingRefresh(true){ idToken, error in
                        if let error = error {
                          // Handle error
                          return;
                        }
                        print("token\(idToken)")

                       
                      }
                    
                }
            })
            }
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
        
        baseView.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "背景1"))
        
        
        NSLayoutConstraint.activate([
            mailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mailTextField.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 272),
            mailTextField.widthAnchor.constraint(equalToConstant: 303),
            mailTextField.heightAnchor.constraint(equalToConstant: 53)
        ])
        mailTextField.backgroundColor = UIColor(hex: "E4EFDD")
        mailTextField.clipsToBounds = true
        mailTextField.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        paddingView.backgroundColor = .clear
        mailTextField.leftView = paddingView
        mailTextField.leftViewMode = .always
        mailTextField.attributedPlaceholder = NSAttributedString(string: "なまえ", attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: "658350")])
        
        
        NSLayoutConstraint.activate([
            passTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor
                                               , constant: 20),
            passTextField.widthAnchor.constraint(equalToConstant: 303),
            passTextField.heightAnchor.constraint(equalToConstant: 53)
        ])
        passTextField.backgroundColor = UIColor(hex: "E4EFDD")
        passTextField.clipsToBounds = true
        passTextField.layer.cornerRadius = 8
        passTextField.attributedPlaceholder = NSAttributedString(string: "パスワード", attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: "658350")])
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        paddingView2.backgroundColor = .clear
        passTextField.leftView = paddingView2
        passTextField.leftViewMode = .always
        
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 88),
            button.widthAnchor.constraint(equalToConstant: 303),
            button.heightAnchor.constraint(equalToConstant: 49)
        
        ])
        button.setImage(UIImage(imageLiteralResourceName: "ログイン"), for: .normal)
        button.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
    }
}
