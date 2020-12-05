//
//  PurchaceViewModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/05.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import RxCocoa

protocol PurchaceViewModelInputs {
    var onTapPurchaceButton: PublishRelay<Void> { get }
}

protocol PurchaceViewModelOutputs {
    var  data: PublishRelay<CommonData> { get }
}

protocol PurchaceViewModelType {
    var inputs: PurchaceViewModelInputs { get }
    var outputs: PurchaceViewModelOutputs { get }
}

class PurchaceViewModel: PurchaceViewModelInputs, PurchaceViewModelOutputs, PurchaceViewModelType {
    var onTapPurchaceButton: PublishRelay<Void> = .init()
    
    var data: PublishRelay<CommonData> = .init()
    
    var inputs: PurchaceViewModelInputs { return self }
    
    var outputs: PurchaceViewModelOutputs { return self }
    
    let disposebag = DisposeBag()
    
    init() {
        onTapPurchaceButton.subscribe(onNext: { [weak self] _ in
            guard let self = self  else { return }
            self.test()
        }).disposed(by: disposebag)
    }
    func test(){}
}

