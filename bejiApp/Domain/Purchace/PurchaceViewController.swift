//
//  PurchaceViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Alamofire
import RxSwift

final class PurchaceViewController: UIViewController {
    private let baseView: UIView = .init()
    private let plantImageView: UIImageView = .init()
    private let button: UIButton = .init()
    private var type : Vegitable?
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        guard let value: String = UserDefaults.standard.string(forKey: "bejiType") else { fatalError()}
        type = value.getUserDefaultsPlant()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setRx()
    }
    private func setRx(){
        button.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { fatalError()}
            self.performSegue(withIdentifier: "toPlants", sender: nil)
        }).disposed(by: disposeBag)
    }
}
extension PurchaceViewController {
    private func setUp(){
        self.navigationItem.titleView = UIImageView(image: type?.nameImage)
        self.view.addSubviews(button).activateAutoLayout()
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 352),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -45)
        ])
        button.setImage(R.image.button.growButton()!, for: .normal)
        self.view.addBackground(image: type!.purchaceImage)
    }
}
