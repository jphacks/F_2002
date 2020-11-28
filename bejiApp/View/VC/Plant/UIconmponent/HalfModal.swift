//
//  HalfModal.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/25.
//

import UIKit

public class HalfModalView: UIView {
    let nameLabel: UILabel = .init()
    let statusImage: UIImageView = .init()
    let borderView: UIView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(){
        
        borderView.backgroundColor = .gray
        nameLabel.text = "テスト"
        statusImage.image = R.image.icon.good()
        addSubview(nameLabel)
        addSubview(statusImage)
        addSubview(borderView)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 43),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -4),
            nameLabel.trailingAnchor.constraint(equalTo: statusImage.leadingAnchor, constant: -140)
        ])
        NSLayoutConstraint.activate([
            statusImage.widthAnchor.constraint(equalToConstant: 43),
            statusImage.heightAnchor.constraint(equalToConstant: 43),
            statusImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            statusImage.topAnchor.constraint(equalTo: self.topAnchor),
            statusImage.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -4)
        ])
        NSLayoutConstraint.activate([
            borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor) ,
            borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        
        
        ])
        nameLabel.font = .systemFont(ofSize: 30)
    }
    func setTitle(title: String){
        nameLabel.text = title
    }
    func setImage(image: UIImage) {
        statusImage.image = image
    }
}

