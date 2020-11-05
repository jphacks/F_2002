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

//API実装loading時に植物の会話データ取得

class ChatViewController: MessagesViewController, MessageCellDelegate, MessagesLayoutDelegate {
    var messageList: [MockMessage] = []
    let testView: UIButton = .init()
    var tested: String = "" {
        didSet {
            let attributedText = NSAttributedString(string: tested, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                                 .foregroundColor: UIColor.white])
            let message = MockMessage(attributedText: attributedText, sender: currentSender() as! Sender, messageId:UUID().uuidString , date: Date())
            messageList.append(message)
            messagesCollectionView.insertSections([messageList.count - 1])
            self.messagesCollectionView.reloadData()
            messagesCollectionView.scrollToBottom()

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
        setUp()
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
        clearButton.backgroundColor = .red
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
        
        scrollsToBottomOnKeyboardBeginsEditing = true
        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.attributedText = NSAttributedString(string: tested, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                                                       .foregroundColor: UIColor.black])
        let items = [
            makeButton(named: "Vector").onTextViewDidChange { button, textView in
                button.tintColor = UIColor(hex: "749B59")
                button.isEnabled = textView.text.isEmpty
            }
        ]
        items.forEach { $0.tintColor = UIColor(hex: "749B59") }
        messageInputBar.setStackViewItems(items, forStack: .left, animated: false)
        messageInputBar.setLeftStackViewWidthConstant(to: 45, animated: false)
        messageInputBar.leftStackView.translatesAutoresizingMaskIntoConstraints = false
        messageInputBar.leftStackView.leadingAnchor.constraint(equalTo: self.messageInputBar.leadingAnchor, constant: 10).isActive = true
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
                print("Item Tapped")
                //カメラ起動
                let storyboard: UIStoryboard = self.storyboard!
                let nextView = storyboard.instantiateViewController(withIdentifier: "ChatResponse") as! ChatResponseViewController
                self.present(nextView, animated: true, completion: nil)
                
                
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
        return Sender(id: "456", displayName: "こんにゃく")
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    // メッセージの上に文字を表示
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

// メッセージのdelegate
extension ChatViewController: MessagesDisplayDelegate {
    
    // メッセージの色を変更（デフォルトは自分：白、相手：黒）
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .darkText : .darkText
    }
    
    // メッセージの背景色を変更している（デフォルトは自分：緑、相手：グレー）
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ?
            .white :
            .white
    }
    
    // メッセージの枠にしっぽを付ける
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
    // アイコンをセット
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        // message.sender.displayNameとかで送信者の名前を取得できるので
        // そこからイニシャルを生成するとよい
        let avatar = Avatar(initials: "こ")
        avatarView.set(avatar: avatar)
    }
}


// 各ラベルの高さを設定（デフォルト0なので必須）
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
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        //        for component in inputBar.inputTextView.components {
        //            if let image = component as? UIImage {
        //
        //                let imageMessage = MockMessage(image: image, sender: currentSender() as! Sender , messageId: UUID().uuidString, date: Date())
        //                messageList.append(imageMessage)
        //                messagesCollectionView.insertSections([messageList.count - 1])
        //
        //            } else if let text = component as? String {
        
        let attributedText = NSAttributedString(string: tested, attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                             .foregroundColor: UIColor.white])
        let message = MockMessage(attributedText: attributedText, sender: currentSender() as! Sender, messageId:UUID().uuidString , date: Date())
        messageList.append(message)
        messagesCollectionView.insertSections([messageList.count - 1])
        //            }
        //        }
        inputBar.inputTextView.text = String()
        messagesCollectionView.scrollToBottom()
        
    }
}



