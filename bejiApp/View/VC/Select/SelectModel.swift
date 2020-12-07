//
//  SelectModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/07.
//

import Foundation
import UIKit

protocol SelectModelProtocol {
    func postUserDefaults(type: BejiMock)
}

final class SelectModel: SelectModelProtocol {
    func postUserDefaults(type: BejiMock) {
        UserDefaults.standard.setValue(type.chatName, forKey: "bejiType")
    }
}
