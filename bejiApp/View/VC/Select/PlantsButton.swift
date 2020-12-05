//
//  PlantsButton.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/05.
//

import Foundation
import UIKit

class PlantButton: UIButton {
    var plantType: BejiMock = .ichigo
    
    init(type: BejiMock) {
        super.init(frame: .zero)
        self.plantType = type
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
