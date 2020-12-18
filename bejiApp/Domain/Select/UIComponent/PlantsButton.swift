//
//  PlantsButton.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/05.
//

import Foundation
import UIKit
import RxSwift

class PlantButton: UIButton {
    var plantType: PublishSubject<Vegitable> = .init()
    var type: Vegitable = .ichigo
    init(type: Vegitable) {
        super.init(frame: .zero)
        self.type = type
        self.setImage(type.plantsButtonImage, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func didSelect() {
        plantType.on(.next(type))
    }
    
}
