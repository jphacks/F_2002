//
//  ChatViewController.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import UIKit
import MessageKit
import Messages
import MessageUI
import InputBarAccessoryView
import CoreLocation
import ActionSheetPicker_3_0
import FirebaseDatabase
import Firebase
import RxSwift

 class ChatViewController: MessagesViewController, MessageCellDelegate, MessagesLayoutDelegate, UINavigationControllerDelegate {
    private var messageList: [ChatMessageType] = []
    var mockViewData: CommonData = .init(token: nil, type: .ichigo, uid: "2EXSKlJkJWSqzoCh7oi3WpKukHF3", cultivationId: nil)
    private let baseView: UIView = .init()
    private let disposebag = DisposeBag()
    let viewModel = ChatViewModel()
    lazy var chatModel: Chat = .init(type: mockViewData.type)
    let clearButton: UIButton = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRx()
        setUp()
    }
    
    func setRx(){
        clearButton.rx.tap.subscribe(onNext: {
            ActionSheetStringPicker.show(withTitle: "会話を選ぼう!!",
                                         rows: self.chatModel.userMessageString,
                                         initialSelection: 1,
                                         doneBlock: { picker, value, index in
                                            self.viewModel.inputs.onTapMessageButton.accept(index as! String)
                                            return
                                         },
                                         cancel: { picker in
                                            return
                                         },
                                         origin: self.clearButton)
        }).disposed(by: disposebag)
        
        viewModel.outputs.chatData.subscribe(onNext: { [weak self] data in
            guard let self = self else { fatalError() }
            self.messageList.append(self.createUserMessage(text: data.message))
            self.reloadMessage()
        }).disposed(by: disposebag)
        
        viewModel.outputs.chatPlantData.subscribe(onNext: { [weak self] data in
            guard let self = self else { fatalError() }
            self.messageList.append(self.createPlantMessage(text: data.message))
            self.reloadMessage()
        }).disposed(by: disposebag)
        
        viewModel.outputs.chatDatas.subscribe(onNext: { [weak self] data in
            guard let self = self else { fatalError() }
            if data.count == 1 {
            } else {
                data.forEach {
                    if $0.title == "me"{
                        self.loadUserMessage(message: $0.message)
                    }
                    if $0.title == "plants" {
                        self.loadPlantsMessage(message: $0.message)
                    }
                }
            }
        }).disposed(by: disposebag)
        
        viewModel.outputs.chatImage.subscribe(onNext: { [weak self] data in
            guard let self = self else { fatalError() }
            self.postUserImageMessage(data.image)
        }).disposed(by: disposebag)
        
        viewModel.outputs.chatImageReply.subscribe(onNext: { [weak self] data in
            guard let self = self else { fatalError() }
            self.loadPlantsMessage(message: data.message)
        }).disposed(by: disposebag)
        
        
    }
    func makeCameraButton(named: String) -> InputBarButtonItem {
        return InputBarButtonItem()
              .configure {
                $0.spacing = .fixed(10)
                $0.image = R.image.button.cameraButton()?.withRenderingMode(.alwaysTemplate)
                $0.setSize(CGSize(width: 30, height: 30), animated: true)
                
            }.onSelected {
                $0.tintColor = UIColor(hex: "749B59")
            }.onDeselected {
                $0.tintColor = UIColor(hex: "749B59")
            }.onTouchUpInside { [self] _ in
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }
    }
}

extension ChatViewController {
    private func createUserMessage(text: String) -> ChatMessageType {
        let attributedText = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                           .foregroundColor: UIColor.black])
        return ChatMessageType(attributedText: attributedText, sender: currentSender() , messageId: UUID().uuidString, date: Date())
    }
    private func createPlantMessage(text: String) -> ChatMessageType {
        let attributedText = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                           .foregroundColor: UIColor.black])
        return ChatMessageType(attributedText: attributedText, sender: otherSender(), messageId: UUID().uuidString, date: Date())
    }
    private func createUserImageMwessage(image: UIImage) -> ChatMessageType {
        return ChatMessageType(image: image, sender: otherSender(), messageId: UUID().uuidString, date: Date())
    }
    private func createPlantsImageMessage(image: UIImage) -> ChatMessageType {
        return ChatMessageType(image: image, sender: currentSender(), messageId: UUID().uuidString, date: Date())
    }
    private func reloadMessage() {
        self.messagesCollectionView.insertSections([self.messageList.count - 1])
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom()
    }
    private func postUserImageMessage(_ image: UIImage) {
        messageList.append(createUserImageMwessage(image: image))
        reloadMessage()
    }
    private func loadUserMessage(message: String) {
        messageList.append(createUserMessage(text: message))
        self.reloadMessage()
    }
    private func postPlantsImageReplyMessage() {
        self.messageList.append(self.createPlantMessage(text: chatModel.imageMessage))
        self.reloadMessage()
    }
    private func loadPlantsMessage(message: String) {
        messageList.append(createPlantMessage(text: message))
        self.reloadMessage()
    }
}

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return ChatUser(senderId: "", displayName: "自分")
    }
    func otherSender() -> SenderType {
        return ChatUser(senderId: "", displayName: chatModel.type.name)
    }
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 3 == 0 {
            return NSAttributedString(
                string: MessageKitDateFormatter.shared.string(from: message.sentDate),
                attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                             NSAttributedString.Key.foregroundColor: UIColor.darkGray]
            )
        }
        return nil
    }
}
extension ChatViewController: InputBarAccessoryViewDelegate {}

extension ChatViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imag = info[.originalImage] as? UIImage
        UIImageWriteToSavedPhotosAlbum(imag!, nil, nil, nil)
        self.dismiss(animated: true, completion: nil)
        guard let image = imag else { return }
        viewModel.inputs.onTapCameraButton.accept(image)
    }
}
