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

//API実装loading時に植物の会話データ取得

class ChatViewController: MessagesViewController, MessageCellDelegate, MessagesLayoutDelegate, UINavigationControllerDelegate {
    var messageList: [MockMessage] = []
    let testView: UIButton = .init()
    var tested: String = "" {
        didSet {
            let attributedText = NSAttributedString(string: tested, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                                 .foregroundColor: UIColor.white])
            let message = MockMessage(attributedText: attributedText, sender: currentSender() as! Sender, messageId:UUID().uuidString , date: Date())
            messageList.append(message)
            self.reloadMessage()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
    
    var type: BejiType = .ichigo
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: type.nameImage())
        setUp()
    }
    
    func reloadMessage() {
        self.messagesCollectionView.insertSections([self.messageList.count - 1])
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom()
    }
    
    func makeMockReplyMessage(){
        if self.tested == "水の様子はどうかな" {
            self.messageList.append(self.createMessage(text: "水の様子はどうかな返信"))
            self.reloadMessage()
        }
        if self.tested == "病気か知りたいな" {
            self.messageList.append(self.createMessage(text: "病気か知りたいな"))
            self.reloadMessage()
        }
        if self.tested == "栄養は足りてる？" {
            self.messageList.append(self.createMessage(text: "栄養は足りてる？返信"))
            self.reloadMessage()
        }
        if self.tested == "追肥の時期かな" {
            self.messageList.append(self.createMessage(text: "追肥の時期はかな返信"))
            self.reloadMessage()
        }
        if self.tested == "温度はどうかな" {
            self.messageList.append(self.createMessage(text: "温度はどうかな返信"))
            self.reloadMessage()
        }
        if self.tested == "日当たりはどう？" {
            self.messageList.append(self.createMessage(text: "日当たりはどう？返信"))
            self.reloadMessage()
        }
        if self.tested == "おしゃべりしよう" {
            self.messageList.append(self.createMessage(text: "おしゃべりしよう返信"))
            self.reloadMessage()
        }
        
        
        
        
        
    }
    
    func setUp(){
        DispatchQueue.main.async {
            // messageListにメッセージの配列をいれて
            self.messageList = self.getMessages()
            // messagesCollectionViewをリロードして
            self.messagesCollectionView.reloadData()
            // 一番下までスクロールする
            self.messagesCollectionView.scrollToBottom()
        }
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        
        messageInputBar.delegate = self
        messageInputBar.sendButton.tintColor = UIColor.lightGray
        self.view.addSubview(testView)
        testView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testView.widthAnchor.constraint(equalToConstant: 140),
            testView.heightAnchor.constraint(equalToConstant: 80),
            testView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            testView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        messageInputBar.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.backgroundColor = .clear
        NSLayoutConstraint.activate([
            clearButton.heightAnchor.constraint(equalTo: messageInputBar.inputTextView.heightAnchor),
            clearButton.widthAnchor.constraint(equalTo: messageInputBar.inputTextView.widthAnchor),
            clearButton.leadingAnchor.constraint(equalTo: self.messageInputBar.inputTextView.leadingAnchor),
            clearButton.topAnchor.constraint(equalTo: self.messageInputBar.inputTextView.topAnchor)
        ])
        
        
        setupCollectionView()
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.backgroundView.backgroundColor = UIColor(hex: "98B982")
        messageInputBar.inputTextView.backgroundColor = UIColor(hex: "E4EFDD")
        messageInputBar.inputTextView.clipsToBounds = true
        messageInputBar.inputTextView.layer.cornerRadius = 8
        messageInputBar.inputTextView.placeholder = "メッセージを選択してください"
        messageInputBar.inputTextView.placeholderLabelInsets.left = 10
        messageInputBar.inputTextView.leadingAnchor.constraint(equalTo: messageInputBar.leftStackView.trailingAnchor, constant: 10).isActive = true
        messageInputBar.inputTextView.trailingAnchor.constraint(equalTo: messageInputBar.rightStackView.trailingAnchor, constant: -10).isActive = true
        messageInputBar.rightStackView.isHidden = true
        
        scrollsToBottomOnKeyboardBeginsEditing = true
        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.attributedText = NSAttributedString(string: tested, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                                                       .foregroundColor: UIColor.black])
        let items = [
            makeButton(named: "カメラ").onTextViewDidChange { button, textView in
                button.tintColor = UIColor(hex: "749B59")
                button.isEnabled = textView.text.isEmpty
            }
        ]
        items.forEach { $0.tintColor = UIColor(hex: "749B59") }
        messageInputBar.setStackViewItems(items, forStack: .left, animated: false)
        messageInputBar.setLeftStackViewWidthConstant(to: 45, animated: false)
        messageInputBar.leftStackView.translatesAutoresizingMaskIntoConstraints = false
        messageInputBar.leftStackView.leadingAnchor.constraint(equalTo: self.messageInputBar.leadingAnchor, constant: 10).isActive = true
        clearButton.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
    }
    @objc func tapButton(_ sender: UIButton){
        ActionSheetStringPicker.show(withTitle: "会話を選ぼう!!",
                                     rows:  ["水の様子はどうかな", "病気か知りたいな", "栄養は足りてる？","追肥の時期かな","温度はどうかな","日当たりはどう？" , "おしゃべりしよう！"],
                                     initialSelection: 1,
                                     doneBlock: { picker, value, index in
                                        self.tested = index as! String
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
    private func setupCollectionView() {
        guard let flowLayout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else {
            print("Can't get flowLayout")
            return
        }
        if #available(iOS 13.0, *) {
            flowLayout.collectionView?.backgroundColor = UIColor(hex: "FFFEF1")
        }
    }
    
    // サンプル用に適当なメッセージ
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(id: "123", displayName: "自分")
    }
    
    func otherSender() -> Sender {
        return Sender(id: "456", displayName: type.name())
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
        if message.sender.displayName == type.name() {
            let avatar = Avatar(image: type.icon(), initials: "な")
            
            avatarView.set(avatar: avatar)
        }
    }
}
extension ViewController: MessagesLayoutDelegate {
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if indexPath.section % 3 == 0 { return 10 }
        return 0
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
}


extension ChatViewController: InputBarAccessoryViewDelegate {
}

extension ChatViewController:  UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        // "写真を使用"を押下した際、写真アプリに保存する
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        // UIImagePickerController カメラが閉じる
        self.dismiss(animated: true, completion: nil)
        messageList.append(createImageMessage(image: image))
        reloadMessage()
        
    }
}





