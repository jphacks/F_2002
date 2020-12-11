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
    var onTapMessageButton: PublishRelay<Void> { get }
    var onTapCameraButton: PublishRelay<Void> { get }
}

protocol ChatViewModelOutputs {
    var iotData: PublishRelay<CommonData> { get }
    var chatData: PublishRelay<ChatData> { get }
    var chatImage: PublishRelay<ChatImageData> { get }
}

protocol ChatViewModelType {
    var inputs: ChatViewModelInputs { get }
    var outputs: ChatViewModelOutputs { get }
}

class ChatViewModel: ChatViewModelType, ChatViewModelInputs, ChatViewModelOutputs {
    var chatImage: PublishRelay<ChatImageData> = .init()
    
    var inputs: ChatViewModelInputs { return self }
     
    var outputs: ChatViewModelOutputs { return self }
    
    var loadChatData: PublishRelay<Void> = .init()
    
    var onTapMessageButton: PublishRelay<Void> = .init()
    
    var onTapCameraButton: PublishRelay<Void> = .init()
    
    var iotData: PublishRelay<CommonData> = .init()
    
    var chatData: PublishRelay<ChatData> = .init()
    
    let disposebag = DisposeBag()
    
    init() {
        loadChatData.subscribe(onNext: { [weak self] _ in
            guard let self = self  else { return }
            
        }).disposed(by: disposebag)
        
    }
    
    
}
