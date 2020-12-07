//
//  SelectViewModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol SelectViewModelInputs {
    var onTapSelectButton: PublishRelay<BejiMock> { get }
}

protocol SelectViewModelOutputs {
    var  data: PublishRelay<CommonData> { get }
}

protocol SelectViewModelType {
    var inputs: SelectViewModelInputs { get }
    var outputs: SelectViewModelOutputs { get }
}

final class SelectViewModel: SelectViewModelType, SelectViewModelInputs, SelectViewModelOutputs {
    var inputs: SelectViewModelInputs { return self}
    var outputs: SelectViewModelOutputs { return self}
    
    var onTapSelectButton: PublishRelay<BejiMock> = .init()
    var data: PublishRelay<CommonData> = .init()
    let disposebag: DisposeBag = .init()
    let model = SelectModel()
    
    init() {
        onTapSelectButton.subscribe(onNext: { [weak self] type in
            guard let self = self  else { return }
            print(type)
            self.registerPlants(type: type)
        }).disposed(by: disposebag)
    }
    func registerPlants(type: BejiMock){
        model.postUserDefaults(type: type )
    }
}
