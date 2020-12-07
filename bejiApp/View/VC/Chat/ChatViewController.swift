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

final class ChatViewController: MessagesViewController, MessageCellDelegate, MessagesLayoutDelegate, UINavigationControllerDelegate {
    var messageList: [ChatMessageType] = []
    let firebaseManager: FirebaseAction = .init()
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

    private let baseView: UIView = .init()
    //viewdataType使用
    lazy var chatModel: ChatModel = .init(type: appDelegate.viewdata!.type)
    
    var chatText: String = "" {
        didSet {
            self.postUserMessage()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.postPlantsMessage()
            }
        }
    }
    //TextinputView無効化,PickerView用ボタン
    let clearButton: UIButton = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager.databaseRef = Database.database().reference()
        getData() { chat in
            self.loadingExistMessage(data: chat)
        }
        //viewdata
        self.navigationItem.titleView = UIImageView(image: chatModel.type.nameImage)
        //viewdata
        self.view.backgroundColor = UIColor(patternImage: chatModel.type.chatbackground)
        setUp()
    }
    private func loadingExistMessage(data: [ChatDataModel]) {
        if data.count == 1 {
            loadMessage()
        } else {
            data.forEach {
                if $0.title == "me"{
                    loadUserMessage(message: $0.message)
                }
                if $0.title == "plants" {
                    loadPlantsMessage(message: $0.message)
                }
            }
        }
    }
    private func getData(completion: @escaping([ChatDataModel]) -> ()){
        //todo
        guard let uid = appDelegate.viewdata!.uid else { fatalError() }
        //viewdata
        firebaseManager.databaseRef.child("chat_room").child("users/\(uid)/username/\(appDelegate.viewdata!.type.chatName)/").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var chatData: [ChatDataModel] = []
            for item in snapshot.children {
                let child = item as! DataSnapshot
                let dic = child.value as! NSDictionary
                chatData.append(ChatDataModel(title: dic["name"] as? String ?? "", message: dic["message"] as? String ?? ""))
            }
            let value = snapshot.value as? NSDictionary
            let message = value?["message"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            chatData.append(.init(title: message, message: name))
            completion(chatData)
            print("ch\(chatData)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    private func loadMessage() {
        DispatchQueue.main.async {
            self.messageList = self.getMessages()
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom()
        }
    }
    //clearButtonタップ時の挙動
    @objc func tapButton(_ sender: UIButton){
        ActionSheetStringPicker.show(withTitle: "会話を選ぼう!!",
                                     rows: chatModel.userMessageString,
                                     initialSelection: 1,
                                     doneBlock: { picker, value, index in
                                        self.chatText = index as! String
                                        return
                                     },
                                     cancel: { picker in
                                        return
                                     },
                                     origin: sender)
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
    //初期メッセージ
    private func getMessages() -> [ChatMessageType] {
        return [
            createPlantsMessage(text: "チャットルームだよ！会話したい時は下の選択ボタンから話したい内容を選択してね！")
        ]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ChatViewController {
    private func createUserMessage(text: String) -> ChatMessageType {
        let attributedText = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                           .foregroundColor: UIColor.black])
        return ChatMessageType(attributedText: attributedText, sender: currentSender() , messageId: UUID().uuidString, date: Date())
    }
    private func createPlantsMessage(text: String) -> ChatMessageType {
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
    private func postUserMessage() {
        let data = ["name": "me", "message": chatText]
        guard let uid = appDelegate.viewdata!.uid else { fatalError() }
        firebaseManager.databaseRef.child("chat_room").child("users/\(uid)/username/\(appDelegate.viewdata!.type.chatName)/").childByAutoId().setValue(data)
        messageList.append(createUserMessage(text: chatText))
        self.reloadMessage()
    }
    private func postUserImageMessage(_ image: UIImage) {
        messageList.append(createUserImageMwessage(image: image))
        reloadMessage()
    }
    private func loadUserMessage(message: String) {
        messageList.append(createUserMessage(text: message))
        self.reloadMessage()
    }
    private func postPlantsMessage() {
        let reply: String =  chatModel.replayMessage(userMessage: ChatModel.UserMessage(rawValue: chatText)!)
        self.messageList.append(self.createPlantsMessage(text: reply))
        let data = ["name": "plants", "message": reply]
        guard let uid = appDelegate.viewdata!.uid else { fatalError() }
        //viewdata
        firebaseManager.databaseRef.child("chat_room").child("users/\(uid)/username/\(chatModel.type.chatName)/").childByAutoId().setValue(data)
        self.reloadMessage()
    }
    private func postPlantsImageReplyMessage() {
        self.messageList.append(self.createPlantsMessage(text: chatModel.imageMessage))
        self.reloadMessage()
    }
    private func loadPlantsMessage(message: String) {
        messageList.append(createPlantsMessage(text: message))
        self.reloadMessage()
    }
}

extension ChatViewController: MessagesDataSource {
    //ユーザー
    func currentSender() -> SenderType {
        return ChatUser(senderId: "123", displayName: "自分")
    }
    //植物
    func otherSender() -> SenderType {
        //viewdata
        return ChatUser(senderId: "456", displayName: chatModel.type.name)
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
        let image = info[.originalImage] as? UIImage
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        self.dismiss(animated: true, completion: nil)
        postUserImageMessage(image!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.postPlantsImageReplyMessage()
        }
    }
}
