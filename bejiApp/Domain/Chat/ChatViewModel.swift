//
//  ChatViewModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/08.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol ChatViewModelInputs {
    var loadChatData: PublishRelay<Void> { get }
    var onTapMessageButton: PublishRelay<String> { get }
    var onTapCameraButton: PublishRelay<UIImage> { get }
}

protocol ChatViewModelOutputs {
    var iotData: PublishRelay<CommonData> { get }
    var chatDatas: Observable<[ChatData]> { get }
    var chatData: PublishRelay<ChatData> { get }
    var chatPlantData: PublishRelay <ChatData> { get }
    var chatImage: PublishRelay<ChatImageData> { get }
    var chatImageReply: PublishRelay<ChatData> { get }
}

protocol ChatViewModelType {
    var inputs: ChatViewModelInputs { get }
    var outputs: ChatViewModelOutputs { get }
}

class ChatViewModel: ChatViewModelType, ChatViewModelInputs, ChatViewModelOutputs {
        
    var chatImageReply: PublishRelay<ChatData> = .init()
    var chatPlantData: PublishRelay<ChatData> = .init()
    
    var chatData: PublishRelay<ChatData> = .init()
    
    var chatDatas: Observable<[ChatData]>
    
    let model: ChatModel = .init()
    var chatImage: PublishRelay<ChatImageData> = .init()
    
    var inputs: ChatViewModelInputs { return self }
    
    var outputs: ChatViewModelOutputs { return self }
    
    var loadChatData: PublishRelay<Void> = .init()
    
    var onTapMessageButton: PublishRelay<String> = .init()
    
    var onTapCameraButton: PublishRelay<UIImage> = .init()
    
    var iotData: PublishRelay<CommonData> = .init()
    
    let disposebag = DisposeBag()
    
    init() {
        chatDatas = model.getChatData()
        onTapMessageButton.subscribe(onNext: { [weak self] message in
            guard let self = self  else { return }
            self.postUserMessage(message: message)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.postPlantMessage(message: message)
            }
        }
        ).disposed(by: disposebag)
        
        onTapCameraButton.subscribe(onNext: { [weak self] image in
            guard let self = self  else { return }
            self.postImagePlantMassage(image: image)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.postImageUserMessage()
            }
        }
        ).disposed(by: disposebag)
    }
    private func postUserMessage(message: String){
        model.postMessage(message: message).bind(to: chatData).disposed(by: disposebag)
    }
    private func postPlantMessage(message: String){
        model.postPlantsMessage(message: message).bind(to: chatPlantData).disposed(by: disposebag)
    }
    private func postImagePlantMassage(image: UIImage){
        model.postImage(image: image).bind(to: chatImage).disposed(by: disposebag)
    }
    private func postImageUserMessage(){
        //type対応
        model.postImageReply(type: .ichigo).bind(to: chatImageReply).disposed(by: disposebag)
    }
    
    
    
}
