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
    
    var onTapIotButton: PublishRelay<Void> = .init()
    let disposebag = DisposeBag()
    let model = PlantModel()
    var data = CommonData()
    var inputs: PlantViewModelInputs { return self}
    var outputs: PlantViewModelOutputs { return self }
    
    //MARK Input
    var onTapChatButton: PublishRelay<Void> = .init()
    
    //MARK outPut
    var isGoodIot: Observable<Bool>
    var loadChatData: Observable<ChatData>
    var iotData: PublishRelay<IotData> = .init()
    
    init(data: CommonData) {
        self.data = data
        //初期読み込みIOT
        let iot = model.getIotData(data: data)
        isGoodIot = model.isGood(data: data)
        
        //初期読み込みチャットデータ
        loadChatData = model.getChatLastData(data: data)
        
        onTapIotButton.subscribe(onNext: { [weak self] _ in
            guard let self = self  else { return }
            iot.bind(to: self.iotData).disposed(by: self.disposebag)
            
        }).disposed(by: disposebag)
        
    }
    private func getIotData(){
        model.getIotData(data: data).bind(to: iotData).disposed(by: disposebag)
    }
    private func validateIotData(data: IotData) -> Bool {
        if data.humidity.status == "ok" , data.illuminance.status == "ok" , data.solidMoisture.status == "ok"
        { return true
        } else {
            return false
        }
    }
}



