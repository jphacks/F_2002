//
//  PlantViewModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/07.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa

protocol PlantViewModelInputs {
    var onTapChatButton: PublishRelay<Void> { get }
    var onTapIotButton: PublishRelay<Void> { get }
}

protocol PlantViewModelOutputs {
    var iotData: PublishRelay<CommonData> { get }
    var chatData: PublishRelay<ChatData> { get }
}

protocol PlantViewModelType {
    var inputs: PlantViewModelInputs { get }
    var outputs: PlantViewModelOutputs { get }
}

class PlantViewModel: PlantViewModelInputs, PlantViewModelOutputs, PlantViewModelType {
    var chatData: PublishRelay<ChatData> = .init()
    var iotData: PublishRelay<CommonData> = .init()
    var inputs: PlantViewModelInputs { return self}
    var outputs: PlantViewModelOutputs { return self }
    var onTapChatButton: PublishRelay<Void> = .init()
    var onTapIotButton: PublishRelay<Void> = .init()
    let disposebag = DisposeBag()
    let model = PlantModel()
    
    init() {
        onTapIotButton.subscribe(onNext: { [weak self] _ in
            guard let self = self  else { return }
            
        }).disposed(by: disposebag)
        onTapChatButton.subscribe(onNext: { [weak self] _ in
            guard let self = self  else { return }
//            self.getChatLastData(data: <#T##CommonData#>)
        }).disposed(by: disposebag)
        
    }
    func getChatLastData(data: CommonData){
        let data = model.getChatData(data: data)
        
    }
}



