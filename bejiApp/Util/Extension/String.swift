//
//  String.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/07.
//

import Foundation

extension String {
    func postUserDefaults(key: String){
        UserDefaults.standard.set(self, forKey: key)
    }
    func getUserDefaults(key: String) -> String {
        guard let string = UserDefaults.standard.string(forKey: key) else { return  "value is nill"}
        return string
    }
    func getUserDefaultsPlant() -> BejiMock {
        switch self {
            case "strawberry" : return .ichigo
            case "potato" : return .jyagaimo
            case "cucumber" : return .kyuuri
            case "eggplants" : return .nasu
            case "carrot" : return .ninjin
            case "onion" : return .tamanegi
            default: return .jyagaimo
        }
    }
}
