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
    func getIotData(data: CommonData) -> Observable<IotData>
    func getChatLastData(data: CommonData) -> Observable<ChatData>
}

class PlantModel: PlantModelProtocol {
    func getIotData(data: CommonData) -> Observable<IotData> {
        return Observable.create { [self] observer in
            var iotData: IotData?
            firebaseManager.getIotData(viewdata: data) {
                iot in
                iotData = iot
                guard let iotData = iotData else {fatalError()}
                observer.onNext(iotData)
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
    
    private let firebaseManager: FirebaseAction = .init()
    
    init() {
        firebaseManager.databaseRef = Database.database().reference()
    }
}
