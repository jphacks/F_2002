//
//  Model.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation

class UserModel: NSObject {
    var id: Int?
    var name: String?
    var email: String?
    var user_plants: String?
}

class PlantModel: NSObject {
    var id: Int?
    var name: String?
    var kit_name: String?
    var plant_description: String?
    var price: Int?
    var period: Int?
    var difficurty: Int?
    var season_from: Int?
    var season_to: Int?
    var temperatures: Array<Temperature>?
    var waters: Array<Water>?
}

class Temperature: NSObject {
    var id: Int?
    var name: String?
    var value: Int?
}

class Water: NSObject {
    var id: Int?
    var name: String?
    var value: Int?
}
