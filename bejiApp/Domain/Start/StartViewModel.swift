//
//  StartViewModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/03.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import Alamofire

protocol StartViewModelInputs {
    var onTapStartButton: PublishRelay<Void> { get }
}

protocol StartViewModelOutputs {
    var data: PublishRelay<CommonData> { get }
}

protocol StartViewModelType {
    var inputs: StartViewModelInputs { get }
    var outputs: StartViewModelOutputs { get }
}

final class StartViewModel: StartViewModelType, StartViewModelInputs, StartViewModelOutputs {
    private let disposebag = DisposeBag()
    var data: PublishRelay<CommonData> = .init()
    var inputs: StartViewModelInputs { return self }
    var outputs: StartViewModelOutputs { return self }
    var onTapStartButton: PublishRelay<Void> = .init()
    var model = StartModel()
    
    init() {
        onTapStartButton.subscribe(onNext: { [weak self] _ in
            guard let self = self  else { return }
            self.register()
        }).disposed(by: disposebag)
    }
    private func register(){
        model.signInAnonymously().bind(to: data).disposed(by: disposebag)
    }
}
