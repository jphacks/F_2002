//
//  SelectModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/07.
//

import Foundation
import UIKit

protocol SelectModelProtocol {
    func postUserDefaults(type: Vegitable)
}

final class SelectModel: SelectModelProtocol {
    func postUserDefaults(type: Vegitable) {
        UserDefaults.standard.setValue(type.chatName, forKey: "bejiType")
    }
}
