//
//  IotDataModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/28.
//

import Foundation

//struct IotData: Codable {
//    let created: String
////    let cultivationld: String
//    let humidity: Status
//    let illuminance: Status
//    let pressure: Status
//    let solidMoisture: Status
//    let temperture: Status
//    let beji: BejiMock?
////
//
//
//    enum CodingKeys: String, CodingKey {
//        case created = "createdAt"
////        case cultivationld = "cultivationId"
//        case humidity = "humidity"
//        case illuminance = "illuminance"
//        case pressure = "pressure"
//        case solidMoisture = "solid_moisture"
//        case temperture = "temperature"
//        case beji
//        }
//}
//struct Status: Codable {
//    let status: String
//    let value: Int
//
//    enum CodingKeys: String, CodingKey {
//        case status
//        case value
//    }
//}

struct IotData {
    let created: String
    let cultivationld: String
    let humidity: Status
    let illuminance: Status
    let pressure: Status
    let solidMoisture: Status
    let temperture: Status
    let beji: Vegitable?
    
    struct Status {
        let status: String
        let value: Int
    }
}
