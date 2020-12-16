//
//  Log.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/14.
//

import Foundation

class Log {
    static func printLog<T>(type: String, logData: T) {
        print("LogMessage\(type)is\(logData)")
    }
}
