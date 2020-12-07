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
import RxSwift
import RxCocoa

final class StartViewController: UIViewController {
    private let baseView: UIView = .init()
    private let logo: UIImageView = .init()
    private let button: UIButton = .init()
    private let disposeBag = DisposeBag()
//    var viewdata: CommonData!
    private let viewModel: StartViewModel = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setRx()
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelect" {
        }
    }
    func setRx(){
        button.rx.tap.bind(to: viewModel.inputs.onTapStartButton).disposed(by: disposeBag)
        viewModel.outputs.data.subscribe (onNext: {[weak self] data in
            guard let self = self else {return}
            print("Rx\(data)")
            self.performSegue(withIdentifier: "toSelect", sender: nil)
        }).disposed(by: disposeBag)
    }
}

extension StartViewController {
    func setUp() {
        self.view.addSubviews(baseView, logo, button).activateAutoLayout()
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
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
        baseView.addBackground(image: R.image.backGround.nomalBackground()!)
    }
}
