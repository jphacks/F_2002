//
//  ChatModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/11.
//

import Foundation
import UIKit
import Firebase
import RxSwift

protocol ChatModelProtocol {
    //   func loadExistChatData(data: [ChatData])
    func getChatData() -> Observable<[ChatData]>
    func postMessage(message: String) -> Observable<ChatData>
    func postPlantsMessage(message: String) -> Observable<ChatData>
}

class ChatModel: ChatModelProtocol {
    private var auth: Auth?
    private let firebaseManager: FirebaseAction = .init()
    let mockViewData: CommonData = .init(token: nil, type: .jyagaimo, uid: "028FGl4ElrbVR252OwzjEXTxpwJ2", cultivationId: nil)
    init() {
        auth = Auth.auth()
        firebaseManager.databaseRef = Database.database().reference()
    }
    func getChatData() -> Observable<[ChatData]> {
        return Observable.create { [self] observer in
            firebaseManager.getChatData(viewdata: mockViewData) { data in
                observer.onNext(data)
                observer.onCompleted()
                print(data)
            }
            return Disposables.create()
        }
    }
    func postMessage(message: String) -> Observable<ChatData> {
        return Observable.create { [self] observer in
            firebaseManager.postChatData(userMessage: message, viewdata: mockViewData) { data in
                observer.onNext(data)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    func postPlantsMessage(message: String) -> Observable<ChatData> {
        return Observable.create { [self] observer in
            let chatM = Chat(type: mockViewData.type)
            let reply: String =  chatM.replayMessage(userMessage: Chat.UserMessage(rawValue: message)!)
            let data = ["name": "plants", "message": reply]
            guard let uid = mockViewData.uid else { fatalError() }
            firebaseManager.databaseRef.child("chat_room").child("users/\(uid)/username/\(mockViewData.type.chatName)/").childByAutoId().setValue(data)
            let chatData: ChatData = .init(title: data["name"] ?? "", message: data["message"] ?? "")
            observer.onNext(chatData)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    func postImage(image: UIImage)  -> Observable<ChatImageData>{
        return Observable.create { observer in
            let data = ChatImageData(title: "user", image: image)
            //Todo: Firebaseに画像登録処理
            observer.onNext(data)
            observer.onCompleted()
            return Disposables.create()
        }
        
    }
    func postImageReply(type: Vegitable) -> Observable<ChatData> {
        return Observable.create { observer in
            let chat = Chat(type: type)
            let data = ChatData(title: "plants", message: chat.imageMessage)
            observer.onNext(data)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
