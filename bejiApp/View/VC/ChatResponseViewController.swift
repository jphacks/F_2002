//
//  ChatResponseViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit

//画面消去時に会話選択送る
class ChatResponseViewController: UIViewController {
    let test: String = "こんにちは"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapButton(_ sender: Any) {
        let nav = self.presentingViewController  as! UINavigationController
        //呼び出し元のView Controllerを遷移履歴から取得しパラメータを渡す
        let InfoVc = nav.viewControllers[nav.viewControllers.count-1] as! ChatViewController
        InfoVc.tested = self.test  //ここで値渡し
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
