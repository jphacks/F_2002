//
//  OverCurrentTransitioningInteractor.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/26.
//

import Foundation
import UIKit

class OverCurrentTransitioningInteractor: UIPercentDrivenInteractiveTransition {
 /// インタラクションの状態
 ///
 /// - none: 開始していない
 /// - shouldStart: 開始できる（開始していない）
 /// - hasStarted: 開始している
 /// - shouldFinish: 終了できる（終了していない）
 enum State {
     case none
     case shouldStart
     case hasStarted
     case shouldFinish
 }

 var state: State = .none

 var startInteractionTranslationY: CGFloat = 0

 var startHandler: (() -> Void)?

 var resetHandler: (() -> Void)?

 /// インタラクションのキャンセル、終了時のAnimation Durationスピードを変更する
 /// デフォルトのままだと、高速に閉じてしまい、瞬間移動しているように見えるため、ここで調整している。
 override func cancel() {
     completionSpeed = percentComplete
     super.cancel()
 }

 override func finish() {
     completionSpeed = 1.0 - percentComplete
     super.finish()
 }

 func setStartInteractionTranslationY(_ translationY: CGFloat) {
     switch state {
     case .shouldStart:
         /// Interaction開始可能な際にInteraction開始までの間更新し続けることで、開始時のYを保持する
         startInteractionTranslationY = translationY
     case .hasStarted, .shouldFinish, .none:
         break
     }
 }

 func updateStateShouldStartIfNeeded() {
     switch state {
     case .none:
         /// .none -> shouldStartへ更新
         state = .shouldStart
         startHandler?()
     case .shouldStart, .hasStarted, .shouldFinish:
         break
     }
 }

 func reset() {
     state = .none
     startInteractionTranslationY = 0
     resetHandler?()
 }
}

