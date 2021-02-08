//
//  PlantMode.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/07.
//

import Foundation
import UIKit
import Firebase
import RxSwift

protocol PlantModelProtocol {
    func getChatLastData(data: CommonData) -> Observable<ChatData>
    func getIotData(data: CommonData) -> Observable<IotData>
    func isGood(data: CommonData) -> Observable<Bool>
}

class PlantModel: PlantModelProtocol {
    func isGood(data: CommonData) -> Observable<Bool> {
        return Observable.create { [self] observer in
            firebaseManager.getIotData(viewdata: data) {
                iot in
                
                observer.onNext(validateIotData(data: iot))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
   
    func getIotData(data: CommonData) -> Observable<IotData> {
        return Observable.create { [self] observer in
            firebaseManager.getIotData(viewdata: data) {
                iot in
                observer.onNext(iot)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    func getChatLastData(data: CommonData) -> Observable<ChatData> {
        return Observable.create { [self] observer in
            var chatData: [ChatData] = []
            firebaseManager.getChatData(viewdata: data) {
                [weak self]
                chat in
                chatData = chat
                chatData.removeLast()
                let chatlastData = chatData.last ?? .init(title: "plants", message: "よろしく！！")
                observer.onNext(chatlastData)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    private func validateIotData(data: IotData) -> Bool {
        if data.humidity.status == "ok" , data.illuminance.status == "ok" , data.solidMoisture.status == "ok"
        { return true
        } else {
          return false
        }
    }
    private let firebaseManager: FirebaseAction = .init()
    
    init() {
        firebaseManager.databaseRef = Database.database().reference()
    }
}
