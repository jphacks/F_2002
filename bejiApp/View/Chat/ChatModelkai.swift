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

class ChatModelkai: ChatModelProtocol {
    private var auth: Auth?
    private let firebaseManager: FirebaseAction = .init()
    init() {
        auth = Auth.auth()
        firebaseManager.databaseRef = Database.database().reference()
    }
    func getChatData() -> Observable<[ChatData]> {
        return Observable.create { [self] observer in
            let mockViewData: CommonData = .init(token: nil, type: .jyagaimo, uid: "028FGl4ElrbVR252OwzjEXTxpwJ2", cultivationId: nil)
            guard let uid = mockViewData.uid else { fatalError() }
            firebaseManager.databaseRef.child("chat_room").child("users/\(uid)/username/\(mockViewData.type.chatName)/").observeSingleEvent(of: .value, with: { (snapshot) in
                var chatData: [ChatData] = []
                for item in snapshot.children {
                    let child = item as! DataSnapshot
                    let dic = child.value as! NSDictionary
                    chatData.append(ChatData(title: dic["name"] as? String ?? "", message: dic["message"] as? String ?? ""))
                }
                let value = snapshot.value as? NSDictionary
                let message = value?["message"] as? String ?? ""
                let name = value?["name"] as? String ?? ""
                chatData.append(.init(title: message, message: name))
                print("ch\(chatData)")
                observer.onNext(chatData)
                observer.onCompleted()
            })
            { (error) in
                print(error.localizedDescription)
            }
//            firebaseManager.getChatData(viewdata: mockViewData) { data in
//                observer.onNext(data)
//                observer.onCompleted()
//                print(data)
//            }
            return Disposables.create()
        }
    }
    func postMessage(message: String) -> Observable<ChatData> {
        return Observable.create { [self] observer in
            let data = ["name": "me", "message": message]
            let mockViewData: CommonData = .init(token: nil, type: .jyagaimo, uid: "028FGl4ElrbVR252OwzjEXTxpwJ2", cultivationId: nil)
            guard let uid = mockViewData.uid else { fatalError() }
            firebaseManager.databaseRef.child("chat_room").child("users/\(uid)/username/\(mockViewData.type.chatName)/").childByAutoId().setValue(data)
            let chatData: ChatData = .init(title: data["name"] as? String ?? "", message: data["message"] as? String ?? "")
            observer.onNext(chatData)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    func postPlantsMessage(message: String) -> Observable<ChatData> {
        return Observable.create { [self] observer in
            var mockViewData: CommonData = .init(token: nil, type: .jyagaimo, uid: "028FGl4ElrbVR252OwzjEXTxpwJ2", cultivationId: nil)
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
    func postImageReply(type: BejiMock) -> Observable<ChatData> {
        return Observable.create { [self] observer in
            let chat = Chat(type: type)
            let data = ChatData(title: "plants", message: chat.imageMessage)
            observer.onNext(data)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
