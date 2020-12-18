//
//  PlantViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import Firebase
import FirebaseDatabase
import RxSwift

//loading時にユーザー情報に応じた植物情報取得
final class PlantViewController: UIViewController {
    private let commentView: CustomView = .init()
    private let commentLabel: UILabel = .init()
    private let chatButton: UIButton = .init()
    private let dayLabel: UILabel = .init()
    private let iotButton: UIButton = .init()
    private let baseView: UIView = .init()
    private let statusBadSignal: UIImageView = .init()
    private var type : Vegitable?
    private let disposeBag = DisposeBag()
    
    var viewData: CommonData = {
        var data = CommonData()
        guard let value: String = UserDefaults.standard.string(forKey: "bejiType") else { fatalError()}
        guard let id: String = UserDefaults.standard.string(forKey: "uid") else { fatalError()}
        guard let token: String = UserDefaults.standard.string(forKey: "token") else { fatalError()}
        data.type = value.getUserDefaultsPlant()
        data.uid = id
        data.token = token
        return data
    }()
    
    lazy var viewModel: PlantViewModel = .init(data: viewData)
    
    override func loadView() {
        super.loadView()
        guard let value: String = UserDefaults.standard.string(forKey: "bejiType") else { fatalError()}
        type = value.getUserDefaultsPlant()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRx()
        setUp()
    }
    
    func setRx(){
        viewModel.outputs.loadIotData.subscribe(onNext: { [weak self] data in
            guard self != nil else { return }
        }).disposed(by: disposeBag)
        
        viewModel.outputs.loadChatData.subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            print(data.message)
            self.getPalntComment(comment: data.message)
        }).disposed(by: disposeBag)
        
        chatButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.performSegue(withIdentifier: "toChat", sender: nil)
        }).disposed(by: disposeBag)
        
        viewModel.outputs.iotData.subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            //植物成長画像追加
            let vc = SemiModalViewController.make(data: data)
            self.present(vc, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        iotButton.rx.tap.asObservable()
            .bind(to: viewModel.inputs.onTapIotButton)
            .disposed(by: disposeBag)
    }
    func getPalntComment(comment: String){
        commentLabel.text = comment
    }
}

extension PlantViewController {
    func setUp() {
        baseView.addBackground(image: R.image.backGround.decorationBackground()!)
        self.navigationItem.titleView = UIImageView(image: viewData.type.nameImage)
        self.view.addSubviews(baseView).activateAutoLayout()
        baseView.addSubviews(commentView, chatButton, iotButton, dayLabel, statusBadSignal, commentLabel).activateAutoLayout()
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 156),
            commentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            commentView.widthAnchor.constraint(equalToConstant: 298),
            commentView.heightAnchor.constraint(equalToConstant: 140)
        ])
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: commentView.leadingAnchor,constant: 52),
            commentLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor,constant: -40),
            commentLabel.topAnchor.constraint(equalTo: commentView.topAnchor,constant: 50),
        ])
        
        commentLabel.font = .boldSystemFont(ofSize: 20)
        commentLabel.textColor = .black
        commentLabel.clipsToBounds = true
        commentLabel.numberOfLines = 0
        commentLabel.backgroundColor = .white
        commentLabel.textAlignment = .center
        commentLabel.clipsToBounds = true
        commentLabel.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 44),
            dayLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 111),
            dayLabel.widthAnchor.constraint(equalToConstant: 120),
            dayLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        dayLabel.backgroundColor = .clear
        dayLabel.text = "栽培1日目"
        dayLabel.font = .boldSystemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            chatButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 265),
            chatButton.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 107),
            chatButton.widthAnchor.constraint(equalToConstant: 82),
            chatButton.heightAnchor.constraint(equalToConstant: 82)
        ])
        chatButton.setImage(R.image.button.chatButton(), for: .normal)
        NSLayoutConstraint.activate([
            iotButton.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            iotButton.bottomAnchor.constraint(equalTo: baseView.bottomAnchor,constant: -25),
            iotButton.widthAnchor.constraint(equalToConstant: 144),
            iotButton.heightAnchor.constraint(equalToConstant: 191)
        ])
        iotButton.setImage(viewData.type.plant, for: .normal)
        statusBadSignal.image = R.image.icon.badSign()
        NSLayoutConstraint.activate([
            statusBadSignal.centerXAnchor.constraint(equalTo: iotButton.trailingAnchor),
            statusBadSignal.centerYAnchor.constraint(equalTo: iotButton.topAnchor),
            statusBadSignal.widthAnchor.constraint(equalToConstant: 40),
            statusBadSignal.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

