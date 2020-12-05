//
//  IotDataModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/28.
//

import Foundation

struct IotModel {
    let created: String
    let cultivationld: String
    let humidity: Status
    let illuminance: Status
    let pressure: Status
    let solidMoisture: Status
    let temperture: Status
    let beji: BejiMock?
    

    struct Status {
        let status: String
        let value: Int
    }
}
