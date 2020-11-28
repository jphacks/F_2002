//
//  OverCurrentTransitionable.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/26.
//

import Foundation
import UIKit

protocol OverCurrentTransitionable where Self: UIViewController {
    var percentThreshold: CGFloat { get }
    var interactor: OverCurrentTransitioningInteractor { get }
}

extension OverCurrentTransitionable {
    var shouldFinishVerocityY: CGFloat {
        return 1200
    }
}

extension OverCurrentTransitionable {
    func handleTransitionGesture(_ sender: UIPanGestureRecognizer) {

        ///　TableViewからPanGestureを取得する場合、
        /// dismiss開始をsender.state.beganで判断できないため、Interactor.stateで判定している
        switch interactor.state {
        case .shouldStart:
            interactor.state = .hasStarted
            dismiss(animated: true, completion: nil)
        case .hasStarted, .shouldFinish:
            break
        case .none:
            return
        }

        /// セミモーダルが画面の何割移動したかを計算
        let translation = sender.translation(in: view)
        let verticalMovement = (translation.y - interactor.startInteractionTranslationY) / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)

        /// PanGesture.stateごとに、インタラクションの更新、終了、キャンセルを制御
        switch sender.state {
        case .changed:
            /// スクロール量がしきい値を超えたか？　もしくは　スクロール速度がしきい値を超えたか？
            if progress > percentThreshold || sender.velocity(in: view).y > shouldFinishVerocityY {
                interactor.state =  .shouldFinish
            } else {
                interactor.state =  .hasStarted
            }
            interactor.update(progress)
        case .cancelled:
            interactor.cancel()
            interactor.reset()
        case .ended:
            switch interactor.state {
            case .shouldFinish:
                interactor.finish()
            case .hasStarted, .none, .shouldStart:
                interactor.cancel()
            }
            interactor.reset()
        default:
            break
        }
    }
}
