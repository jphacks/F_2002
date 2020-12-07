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
}
