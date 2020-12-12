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
    func getChatData(data: CommonData) -> Observable<[ChatData]>
    
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
    
    
    func getChatData(data: CommonData) -> Observable<[ChatData]> {
        return Observable.create { [self] observer in
            var iotData: [ChatData] = []
            firebaseManager.getChatData(viewdata: data) {
                [weak self]
                chat in
                iotData = chat
                observer.onNext(iotData)
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
