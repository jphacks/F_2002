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
    private let startButton: UIButton = .init()
    private let disposeBag = DisposeBag()
//    var viewdata: CommonData!
    private let viewModel: StartViewModel = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setRx()
    }

    private func setRx(){
        startButton.rx.tap.bind(to: viewModel.inputs.onTapStartButton).disposed(by: disposeBag)
        viewModel.outputs.data.subscribe (onNext: {[weak self] data in
            guard let self = self else { return }
            self.performSegue(withIdentifier: "toSelect", sender: nil)
        }).disposed(by: disposeBag)
    }
}

extension StartViewController {
    private func setUp() {
        let statusBar = UIApplication.shared.statusBarFrame.size.height
        print(statusBar)
        let navigationHeight = self.navigationController?.navigationBar.frame.size.height
        print(navigationHeight!)
        self.view.addSubviews(logo, startButton).activateAutoLayout()
//        NSLayoutConstraint.activate([
//            baseView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 88),
//            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        ])
        NSLayoutConstraint.activate([
//            logo.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 183),
            logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
//        logo.image = R.image.logo()!
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 183),
            startButton.heightAnchor.constraint(equalToConstant: 62),
            startButton.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 157)
        ])
        startButton.setImage(R.image.button.startButton(), for: .normal)
//        baseView.addBackground(image: R.image.backGround.nomalBackground()!)
        self.view.addBackground(image:  R.image.testBackground()!)
        
    }
}
