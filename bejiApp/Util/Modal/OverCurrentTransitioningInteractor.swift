//
//  OverCurrentTransitioningInteractor.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/26.
//

import Foundation
import UIKit

class OverCurrentTransitioningInteractor: UIPercentDrivenInteractiveTransition {
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
         startInteractionTranslationY = translationY
     case .hasStarted, .shouldFinish, .none:
         break
     }
 }

 func updateStateShouldStartIfNeeded() {
     switch state {
     case .none:
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

