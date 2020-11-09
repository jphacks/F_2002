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
import UIKit
import MessageKit
import CoreLocation
import ActionSheetPicker_3_0
import FirebaseDatabase
import Firebase


class ChatViewController: MessagesViewController, MessageCellDelegate, MessagesLayoutDelegate, UINavigationControllerDelegate {
    var messageList: [MockMessage] = []
    let firebaseManager: FirebaseAction = .init()
    var viewdata: Viewdata!
    let testView: UIButton = .init()
    var chatText: String = "" {
        didSet {
            let attributedText = NSAttributedString(string: chatText, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                                 .foregroundColor: UIColor.white])
            let message = MockMessage(attributedText: attributedText, sender: currentSender() as! Sender, messageId:UUID().uuidString , date: Date())
            firebaseManager.uploadChatData(from: "me", to: "plant", message: chatText, imageUrl: nil)
            messageList.append(message)
            self.reloadMessage()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.makeMockReplyMessage()
            }
            
        }
    }
    
    var alertmessage: String = "" {
        didSet {
            messageList.append(createMessage(text: alertmessage))
            reloadMessage()
            
        }
    }
    let clearButton: UIButton = .init()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: viewdata.type.nameImage())
        self.view.backgroundColor = UIColor(patternImage: viewdata.type.chatbackground())
        firebaseManager.databaseRef = Database.database().reference()
        setUp()
    }
    
    func reloadMessage() {
        self.messagesCollectionView.insertSections([self.messageList.count - 1])
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom()
    }
    //モックよう返信メッセージ
    func makeMockReplyMessage(){
        if self.chatText == "水の様子はどうかな" {
            let text = viewdata.type.messageWater()
            self.messageList.append(self.createMessage(text: text))
            firebaseManager.uploadChatData(from: "plant", to: "me", message:text , imageUrl: nil)
            self.reloadMessage()
        }
        if self.chatText == "病気か知りたいな" {
            self.messageList.append(self.createMessage(text: viewdata.type.messageStatus()))
            firebaseManager.uploadChatData(from: "plant", to: "me", message:viewdata.type.messageStatus() , imageUrl: nil)
            self.reloadMessage()
        }
        if self.chatText == "栄養は足りてる？" {
            self.messageList.append(self.createMessage(text: viewdata.type.messageNutri()))
            firebaseManager.uploadChatData(from: "plant", to: "me", message:viewdata.type.messageNutri() , imageUrl: nil)
            self.reloadMessage()
        }
        if self.chatText == "追肥の時期かな" {
            self.messageList.append(self.createMessage(text: viewdata.type.messageTuihi()))
            firebaseManager.uploadChatData(from: "plant", to: "me", message:viewdata.type.messageTuihi() , imageUrl: nil)
            self.reloadMessage()
        }
        if self.chatText == "温度はどうかな" {
            self.messageList.append(self.createMessage(text: viewdata.type.messageTem()))
            firebaseManager.uploadChatData(from: "plant", to: "me", message:viewdata.type.messageTem() , imageUrl: nil)
            self.reloadMessage()
        }
        if self.chatText == "日当たりはどう？" {
            self.messageList.append(self.createMessage(text:viewdata.type.messageSun()))
            firebaseManager.uploadChatData(from: "plant", to: "me", message:viewdata.type.messageSun() , imageUrl: nil)
            self.reloadMessage()
        }
        if self.chatText == "おしゃべりしよう！" {
            self.messageList.append(self.createMessage(text: viewdata.type.messageFree()))
            firebaseManager.uploadChatData(from: "plant", to: "me", message:viewdata.type.messageWater() , imageUrl: nil)
            self.reloadMessage()
        }
    }
    //画像用返信メタデータ送る
    func makeMockImageReply(){
        self.messageList.append(self.createMessage(text: viewdata.type.imageMessage()))
        self.reloadMessage()
    }
    
    
    @objc func tapButton(_ sender: UIButton){
        ActionSheetStringPicker.show(withTitle: "会話を選ぼう!!",
                                     rows:  ["水の様子はどうかな", "病気か知りたいな", "栄養は足りてる？","追肥の時期かな","温度はどうかな","日当たりはどう？" , "おしゃべりしよう！"],
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
    
    func makeButton(named: String) -> InputBarButtonItem {
        return InputBarButtonItem()
            .configure {
                $0.spacing = .fixed(10)
                $0.image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
                $0.setSize(CGSize(width: 30, height: 30), animated: true)
                
            }.onSelected {
                $0.tintColor = UIColor(hex: "749B59")
            }.onDeselected {
                $0.tintColor = UIColor(hex: "749B59")
            }.onTouchUpInside { _ in
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
                
            }
    }
    //初期メッセージ
    func getMessages() -> [MockMessage] {
        return [
            createMessage(text: "チャットルームだよ！会話したい時は下の選択ボタンから話したい内容を選択してね！")
            
        ]
    }
    //相手用
    func createMessage(text: String) -> MockMessage {
        let attributedText = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                           .foregroundColor: UIColor.black])
        return MockMessage(attributedText: attributedText, sender: otherSender(), messageId: UUID().uuidString, date: Date())
    }
    func createImageMessage(image: UIImage) -> MockMessage {
        return MockMessage(image: image, sender: otherSender(), messageId: UUID().uuidString, date: Date())
    }
    func createImageMessageToOther(image: UIImage) -> MockMessage {
        return MockMessage(image: image, sender:currentSender() as! Sender , messageId: UUID().uuidString, date: Date())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(id: "123", displayName: "自分")
    }
    
    func otherSender() -> Sender {
        return Sender(id: "456", displayName: viewdata.type.name())
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
extension ChatViewController: MessagesDisplayDelegate {
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .black : .darkText
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ?
            UIColor(hex: "98B982") :
            .white
    }
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if message.sender.displayName == "自分" {}
        if message.sender.displayName == viewdata.type.name() {
            let avatar = Avatar(image: viewdata.type.getIcon(), initials: "な")
            
            avatarView.set(avatar: avatar)
        }
    }
}
extension ViewController: MessagesLayoutDelegate {}

extension ChatViewController: InputBarAccessoryViewDelegate {}

extension ChatViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        // "写真を使用"を押下した際、写真アプリに保存する
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        // UIImagePickerController カメラが閉じる
        self.dismiss(animated: true, completion: nil)
        messageList.append(createImageMessageToOther(image: image))
        reloadMessage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.makeMockImageReply()
        }
        
    }
}



