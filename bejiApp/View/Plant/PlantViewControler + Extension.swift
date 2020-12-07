//
//  PlantViewControler + Extension.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/27.
//

import Foundation
import UIKit

extension PlantViewController {
    func setUp() {
        baseView.addBackground(image: R.image.backGround.decorationBackground()!)
        self.navigationItem.titleView = UIImageView(image: appDelegate.viewdata!.type.nameImage)
        self.view.addSubview(baseView)
        baseView.addSubviews(commentView, chatButton, iotButton, dayLabel, statusBadSignal, commentLabel).activateAutoLayout()
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 88),
            baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 156),
            commentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            commentView.widthAnchor.constraint(equalToConstant: 298),
            commentView.heightAnchor.constraint(equalToConstant: 140)
        ])
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: commentView.leadingAnchor,constant: 52),
            commentLabel.trailingAnchor.constraint(equalTo: commentView.trailingAnchor,constant: -40),
            commentLabel.topAnchor.constraint(equalTo: commentView.topAnchor,constant: 50),
        ])
        commentLabel.text = "これからの成長が楽しみ！！！"
        commentLabel.font = .boldSystemFont(ofSize: 20)
        commentLabel.textColor = .black
        commentLabel.clipsToBounds = true
        commentLabel.numberOfLines = 0
        commentLabel.backgroundColor = .white
        commentLabel.textAlignment = .center
        commentLabel.clipsToBounds = true
        commentLabel.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 44),
            dayLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 111),
            dayLabel.widthAnchor.constraint(equalToConstant: 120),
            dayLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        dayLabel.backgroundColor = .clear
        dayLabel.text = "栽培1日目"
        dayLabel.font = .boldSystemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            chatButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 265),
            chatButton.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 107),
            chatButton.widthAnchor.constraint(equalToConstant: 82),
            chatButton.heightAnchor.constraint(equalToConstant: 82)
        ])
        chatButton.setImage(R.image.button.chatButton(), for: .normal)
        NSLayoutConstraint.activate([
            iotButton.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            iotButton.bottomAnchor.constraint(equalTo: baseView.bottomAnchor,constant: -25),
            iotButton.widthAnchor.constraint(equalToConstant: 144),
            iotButton.heightAnchor.constraint(equalToConstant: 191)
        ])
        iotButton.setImage(appDelegate.viewdata!.type.plant, for: .normal)
        chatButton.addTarget(self,action: #selector(self.tapButton(_ :)),for: .touchUpInside)
        iotButton.addTarget(self,action: #selector(self.tapiotButton(_ :)),for: .touchUpInside)
        statusBadSignal.image = R.image.icon.badSign()
        NSLayoutConstraint.activate([
            statusBadSignal.centerXAnchor.constraint(equalTo: iotButton.trailingAnchor),
            statusBadSignal.centerYAnchor.constraint(equalTo: iotButton.topAnchor),
            statusBadSignal.widthAnchor.constraint(equalToConstant: 40),
            statusBadSignal.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
