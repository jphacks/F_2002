//
//  SemiModalViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/26.
//

import UIKit

public class SemiModalViewController: UIViewController, OverCurrentTransitionable {

    var percentThreshold: CGFloat = 0.3
    var interactor = OverCurrentTransitioningInteractor()

    private var tableViewContentOffsetY: CGFloat = 0.0

    let contentView: UIView = .init()
    let tableView: UITableView = .init()
    let backgroundView: UIView = .init()
    let waterLabel: HalfModalView = .init()
    let sunLabel: HalfModalView = .init()
    let humidityLabel: HalfModalView = .init()
    let iconImageView: UIImageView = .init()
    let timelabel: UILabel = .init()
    let commentLabel: UILabel = .init()
    
    
    let labelStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 20
        return view
    }()
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        interactor.startHandler = { [weak self] in
            self?.tableView.bounces = false
        }
        interactor.resetHandler = { [weak self] in
            self?.tableView.bounces = true
        }
        setupViews()
    }
    func setLayout(){
        self.view.addSubviews(backgroundView, contentView).activateAutoLayout()
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/2)
        ])
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.backgroundView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        backgroundView.backgroundColor = .clear
        self.view.backgroundColor = .clear
        contentView.addSubviews(labelStackView, iconImageView).activateAutoLayout()
        labelStackView.addArrangedSubviews(waterLabel, sunLabel, humidityLabel).activateAutoLayout()
        contentView.addSubviews(timelabel, commentLabel).activateAutoLayout()
        NSLayoutConstraint.activate([
            commentLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            commentLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 6),
        ])
        
        NSLayoutConstraint.activate([
            timelabel.topAnchor.constraint(equalTo: self.commentLabel.bottomAnchor),
            timelabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        ])
        commentLabel.font = .boldSystemFont(ofSize: 22)
        timelabel.font = .systemFont(ofSize: 15)
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: self.timelabel.bottomAnchor, constant: 20),
//            labelStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 55),
            labelStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -55)
            
        ])
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 110),
            iconImageView.heightAnchor.constraint(equalToConstant: 110),
            iconImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.contentView.topAnchor)
        ])
        
        waterLabel.setTitle(title: "水分")
        sunLabel.setTitle(title: "日光")
        humidityLabel.setTitle(title: "湿度")
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8.0
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let headerGesture = UIPanGestureRecognizer(target: self, action: #selector(headerDidScroll(_:)))
        contentView.addGestureRecognizer(headerGesture)

        let gesture = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap))
        backgroundView.addGestureRecognizer(gesture)

        let tableViewGesture = UIPanGestureRecognizer(target: self, action: #selector(tableViewDidScroll(_:)))
        tableViewGesture.delegate = self
        tableView.addGestureRecognizer(tableViewGesture)
        tableView.delegate = self
        tableView.dataSource = self
    }

    static func make(data: IotData ) -> SemiModalViewController {
        let sb = UIStoryboard(name: "SemiModalViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! SemiModalViewController
        vc.updateStatus(data: data)
        vc.iconImageView.image = data.beji?.bigIcon
        return vc
    }
    func updateStatus(data: IotData){
        timelabel.text = data.created
        commentLabel.text = data.beji?.iotGoodStatus
        commentLabel.textColor = .black
        print(data.humidity.status)
        print(data.solidMoisture.status)
        print(data.illuminance.status)
        //Todo: アイコン変更
        if data.humidity.status == "ng"{
            humidityLabel.setImage(image: R.image.icon.bad()!)
            commentLabel.text = data.beji?.iotBadStatushumidity
            commentLabel.textColor = .red
        }
        if data.solidMoisture.status == "ng" {
            waterLabel.setImage(image: R.image.icon.bad()!)
            commentLabel.text = data.beji?.iotBadStatusWater
            commentLabel.textColor = .red
        }
        if data.illuminance.status == "ng" {
            sunLabel.setImage(image: R.image.icon.bad()!)
            commentLabel.text = data.beji?.iotBadstatusIlluminance
            commentLabel.textColor = .red
        }
    }
    @objc private func backgroundDidTap() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func headerDidScroll(_ sender: UIPanGestureRecognizer) {
        /// ヘッダービューをスワイプした場合の処理
        /// コールされたと同時にインタラクション開始する。
        interactor.updateStateShouldStartIfNeeded()
        handleTransitionGesture(sender)
    }

    @objc private func tableViewDidScroll(_ sender: UIPanGestureRecognizer) {
        /// テーブルビューをスワイプした場合の処理
        /// テーブルビューのスクロールがトップ位置にまでスクロールされた場合にインタラクションを開始
        if tableViewContentOffsetY <= 0 {
            interactor.updateStateShouldStartIfNeeded()
        }
        /// インタラクション開始位置と、テーブルビュースクロール開始位置が異なるため、インタラクション開始時のY位置を取得している
        interactor.setStartInteractionTranslationY(sender.translation(in: view).y)
        handleTransitionGesture(sender)
    }
}

extension SemiModalViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableViewContentOffsetY = scrollView.contentOffset.y
    }
}

extension SemiModalViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

/// 以下デリゲートメソッドで、セミモーダルの閉じる処理に関する設定している
extension SemiModalViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ///　セミモーダル遷移時の背景透過アニメーションを行うPresentationControllerを返却
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        /// dismiss時のアニメーションを定義したクラスを返却
        return DismissAnimator()
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        /// インタラクション開始している場合にはinteractorを返却する
        /// 開始していない場合はnilを返却することでインタラクション無しのdissmissとなる
        switch interactor.state {
        case .hasStarted, .shouldFinish:
            return interactor
        case .none, .shouldStart:
            return nil
        }
    }
}
