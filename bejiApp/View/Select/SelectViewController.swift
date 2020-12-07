//
//  SelectViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Firebase
import Alamofire
import RxSwift
import RxCocoa

final class SelectViewController: UIViewController {
    private let potatoButton: PlantButton = .init(type: .jyagaimo)
    private let onionButton: PlantButton = .init(type: .tamanegi)
    private let carrotButton: PlantButton = .init(type: .ninjin)
    private let strawberryButton: PlantButton = .init(type: .ichigo)
    private let eggplantsButton: PlantButton = .init(type: .nasu)
    private let cucamberButton: PlantButton = .init(type: .kyuuri)
    private let baseView: UIView = .init()
    private let disposeBag: DisposeBag = .init()
    lazy var buttons: [PlantButton] = [potatoButton,onionButton,carrotButton,strawberryButton,eggplantsButton,cucamberButton]
    var viewModel = SelectViewModel()
    private let leftStackView: UIStackView = {
        let view: UIStackView = .init()
        view.alignment = .leading
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 22
        return view
    }()
    private let rightStackView: UIStackView =  {
        let view: UIStackView = .init()
        view.alignment = .center
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 22
        return view
    }()
    private let bigStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: R.image.plate.selectPlantsPlate())
        baseView.addBackground(image: R.image.backGround.nomalBackground()! )
        setUp()
        setRx()
    }
    private func setRx(){
        buttons.forEach {
            let type = $0.type
            $0.rx.tap.subscribe(onNext:  { [weak self] in
                guard let self = self else { fatalError()}
                self.viewModel.inputs.onTapSelectButton.accept(type)
                self.performSegue(withIdentifier: "toPurchace", sender: nil)
            }).disposed(by: disposeBag)
            
        }
    }
    
}
extension SelectViewController {
    private func setUp() {
        self.navigationItem.hidesBackButton = true
        self.view.addSubviews(baseView).activateAutoLayout()
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        baseView.addSubviews(bigStackView).activateAutoLayout()
        bigStackView.addArrangedSubviews(leftStackView, rightStackView).activateAutoLayout()
        leftStackView.addArrangedSubviews(potatoButton, onionButton, carrotButton).activateAutoLayout()
        rightStackView.addArrangedSubviews(strawberryButton, eggplantsButton, cucamberButton).activateAutoLayout()
        
        NSLayoutConstraint.activate([
            bigStackView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            bigStackView.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            leftStackView.widthAnchor.constraint(equalToConstant: 127 ),
            leftStackView.heightAnchor.constraint(equalToConstant: 444)
        ])
        buttons.forEach {
            $0.widthAnchor.constraint(equalToConstant: 127).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 132).isActive = true
        }
    }
}
