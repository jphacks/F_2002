//
//  ChatVC + Extension.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/08.
//

import Foundation
import UIKit
import MessageKit
import Messages
import MessageUI
import InputBarAccessoryView
import CoreLocation
import ActionSheetPicker_3_0
import FirebaseDatabase
import Firebase

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
        if message.sender.displayName == mockViewData.type.name {
            let avatar = Avatar(image: mockViewData.type.getIcon, initials: "hoge")
            avatarView.set(avatar: avatar)
        }
    }
}
extension ChatViewController {
    func setUp() {
        self.navigationItem.titleView = UIImageView(image: chatModel.type.nameImage)
        self.view.backgroundColor = UIColor(patternImage: chatModel.type.chatbackground)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messageInputBar.delegate = self
        messageInputBar.sendButton.tintColor = UIColor.lightGray
        messageInputBar.addSubviews(clearButton).activateAutoLayout()
        messageInputBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.heightAnchor.constraint(equalTo: messageInputBar.inputTextView.heightAnchor),
            clearButton.widthAnchor.constraint(equalTo: messageInputBar.inputTextView.widthAnchor),
            clearButton.leadingAnchor.constraint(equalTo: self.messageInputBar.inputTextView.leadingAnchor),
            clearButton.topAnchor.constraint(equalTo: self.messageInputBar.inputTextView.topAnchor)
        ])
        setupCollectionView()
        maintainPositionOnKeyboardFrameChanged = true
        scrollsToBottomOnKeyboardBeginsEditing = true
        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
//        messageInputBar.inputTextView.attributedText = NSAttributedString(string: chatText, attributes: [.font: UIFont.systemFont(ofSize: 15),
//                                                                                                         .foregroundColor: UIColor.black])
        let items = [
            makeCameraButton(named: "カメラ").onTextViewDidChange { button, textView in
                button.tintColor = UIColor(hex: "749B59")
                button.isEnabled = textView.text.isEmpty
            }
        ]
        items.forEach { $0.tintColor = UIColor(hex: "749B59") }
        messageInputBar.setStackViewItems(items, forStack: .left, animated: false)
        setMessageInputBar()
    }
    func setupCollectionView() {
           guard let flowLayout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout else {
               print("Can't get flowLayout")
               return
           }
           if #available(iOS 13.0, *) {
               flowLayout.collectionView?.backgroundColor = .clear
           }
    }
    func setMessageInputBar(){
        messageInputBar.backgroundView.backgroundColor = .clear
        messageInputBar.backgroundView.backgroundColor = UIColor(hex: "98B982")
        messageInputBar.inputTextView.backgroundColor = UIColor(hex: "E4EFDD")
        messageInputBar.inputTextView.clipsToBounds = true
        messageInputBar.inputTextView.layer.cornerRadius = 8
        messageInputBar.inputTextView.placeholder = "メッセージを選択してください"
        messageInputBar.inputTextView.placeholderLabelInsets.left = 10
        messageInputBar.inputTextView.leadingAnchor.constraint(equalTo: messageInputBar.leftStackView.trailingAnchor, constant: 10).isActive = true
        messageInputBar.inputTextView.trailingAnchor.constraint(equalTo: messageInputBar.rightStackView.trailingAnchor, constant: -10).isActive = true
        messageInputBar.rightStackView.isHidden = true
        messageInputBar.setLeftStackViewWidthConstant(to: 45, animated: false)
        messageInputBar.leftStackView.translatesAutoresizingMaskIntoConstraints = false
        messageInputBar.leftStackView.leadingAnchor.constraint(equalTo: self.messageInputBar.leadingAnchor, constant: 10).isActive = true
        
    }
}
