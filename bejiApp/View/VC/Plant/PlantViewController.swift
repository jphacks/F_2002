//
//  PlantViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Firebase
import FirebaseDatabase

//loading時にユーザー情報に応じた植物情報取得
final class PlantViewController: UIViewController {
    let commentView: CustomView = .init()
    let commentLabel: UILabel = .init()
    let chatButton: UIButton = .init()
    let dayLabel: UILabel = .init()
    let iotButton: UIButton = .init()
    let baseView: UIView = .init()
    let statusBadSignal: UIImageView = .init()
    let firebaseManager: FirebaseAction = .init()
    var viewdata: CommonData!
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager.databaseRef = Database.database().reference()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseManager.getIotData(viewdata: viewdata) {data in
            self.loadIotStatus(iot: data)
        }
        firebaseManager.getChatData(viewdata: viewdata) { data in
            var changedata = data
            changedata.removeLast()
            self.getPalntComment(comment: changedata.last?.message ?? "よろしく!!!")
        }
    }
    func getPalntComment(comment: String){
        commentLabel.text = comment
    }
}
extension PlantViewController {
    @objc func tapButton(_ sender: UIButton){
        self.performSegue(withIdentifier: "toChat", sender: viewdata)
    }
    @objc func tapiotButton(_ sender: UIButton){
        firebaseManager.getIotData(viewdata: viewdata) {  data in
            self.iotButton.setImage(self.viewdata.type.glowth, for: .normal)
            let vc = SemiModalViewController.make(data: data)
            self.present(vc, animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChat" {
            let nextVC = segue.destination as! ChatViewController
            nextVC.viewdata = viewdata
        }
    }
    func loadIotStatus(iot: IotModel){
        if iot.humidity.status == "ok" && iot.illuminance.status == "ok" && iot.solidMoisture.status == "ok"
        {
            print("ok")
        } else {
            print("bad")
        }
    }
}
