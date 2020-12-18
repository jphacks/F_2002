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
    var onTapIotButton: PublishRelay<Void> { get }
}

protocol PlantViewModelOutputs {
    var iotData: PublishRelay<IotData> { get }
    var loadChatData: Observable<ChatData> { get }
    var isGoodIot: Observable<Bool> { get }
}

protocol PlantViewModelType {
    var inputs: PlantViewModelInputs { get }
    var outputs: PlantViewModelOutputs { get }
}

class PlantViewModel: PlantViewModelInputs, PlantViewModelOutputs, PlantViewModelType {
    var isGoodIot: Observable<Bool>
    
    var loadChatData: Observable<ChatData>
    
    var loadIotData: Observable<IotData>
    
    var iotData: PublishRelay<IotData> = .init()
    var inputs: PlantViewModelInputs { return self}
    var outputs: PlantViewModelOutputs { return self }
    var onTapChatButton: PublishRelay<Void> = .init()
    var onTapIotButton: PublishRelay<Void> = .init()
    let disposebag = DisposeBag()
    let model = PlantModel()
    var data = CommonData()
    
    init(data: CommonData) {
        self.data = data
        //初期読み込みIOT
        isGoodIot = model.getIotData(data: data)
        //初期読み込みチャットデータ
        loadChatData = model.getChatLastData(data: data)
        
        onTapIotButton.subscribe(onNext: { [weak self] _ in
            guard let self = self  else { return }
//            self.getIotData()
        }).disposed(by: disposebag)
        
    }
//    private func getIotData(){
//        model.getIotData(data: data).bind(to: iotData).disposed(by: disposebag)
//    }
}



