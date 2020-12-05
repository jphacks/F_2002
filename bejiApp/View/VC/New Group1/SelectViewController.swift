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
    let viewModel = SelectViewModel()
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
        baseView.addBackground(image: R.image.backGround.nomalBackground()! )
        setUp()
        self.navigationItem.titleView = UIImageView(image: R.image.plate.selectPlantsPlate())
    }
    @objc
    func onTapPlantButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toPurchace", sender: viewdata)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPurchace" {
            let nextVC = segue.destination as! PurchaceViewController
            nextVC.viewdata = self.viewdata
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
        let buttons: [UIButton] = [potatoButton,onionButton,carrotButton,strawberryButton,eggplantsButton,cucamberButton]
        
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
            $0.rx.tap.bind(to: viewModel.inputs.onTapSelectButton).disposed(by: disposeBag)
            $0.addTarget(self, action: #selector(self.onTapPlantButton(_:)), for: .touchUpInside)
        }
        
        potatoButton.setImage(R.image.button.selectPotato(), for: .normal)
        onionButton.setImage(R.image.button.selectOnion(), for: .normal)
        carrotButton.setImage(R.image.button.selectCarrot(), for: .normal)
        strawberryButton.setImage(R.image.button.selectStrawberry(), for: .normal)
        eggplantsButton.setImage(R.image.button.selectEgplant(), for: .normal)
        cucamberButton.setImage(R.image.button.selectCucumber(), for: .normal)
    }
    private func purchacePlants(data: CommonData) {
        guard let token = data.token else {
            fatalError("notToken")
        }
        let parameters: [String: Any]? = [
            "plant_id": 1,
            "nick_name": "じゃがーくん2世"
        ]
        let header: HTTPHeaders? = ["Authentication": token]
        print("tes確認\(token)")
        let url = "https://d3or1724225rbx.cloudfront.net/user/cultivations/3"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:
                    header ).responseJSON { response  in
                        switch response.result {
                        case .success(let res):
                                print("testjson\(res)")
                        case .failure(let error):
                            print(error)
                        }
        }
    }
}
