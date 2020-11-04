//
//  JsonParser.swift
//  JPHacksSample
//
//  Created by Gyuho on 2020/10/31.
//

import UIKit
import SwiftyJSON

class JsonParser: NSObject {
    class var sharedInstance: JsonParser {
        struct Static {
            static let instance: JsonParser = JsonParser()
        }
        return Static.instance
    }

    // 叩くAPIによってparseするタイプを出しわけ
    func parseJson(_ api: API, json: JSON) -> Any? {
        switch api {
        case .users:
            return nil
        case .plants:
            return self.parsePlantsApiJson(json)
        case .userPlants:
            return nil
        case .user:
            return self.parseProfileApiJson(json)
        case .userChange:
            return nil
        case .userDelete:
            return nil
        case .plant:
            return self.parsePlantApiJson(json)
        case .profile:
            return self.parseProfileApiJson(json)
        case .userPlant:
            return self.parsePlantApiJson(json)
        case .userPlantChange:
            return nil
        case .userPlantDelete:
            return nil
        case .plantWatering:
            return nil
        }
    }

    // プロフィール画面ユーザー情報取得
    private func parseProfileApiJson(_ json: JSON) -> UserModel {
        let userModel = UserModel()
        userModel.id = json["id"].int
        userModel.name = json["name"].string
        userModel.email = json["email"].string
        userModel.user_plants = json["user_plants"].string

        return userModel
    }
    
    private func parsePlantsApiJson(_ json: JSON) -> Array<PlantModel> {
        var plantArr = Array<PlantModel>()
        if let tmpArr = json.array{
            for obj in tmpArr {
                let plantModel = parsePlantApiJson(obj)
                plantArr.append(plantModel)
            }
        }
        return plantArr
    }
    
    // 植物情報取得
    private func parsePlantApiJson(_ json: JSON) -> PlantModel {
        let plantModel = PlantModel()
        plantModel.id = json["id"].int
        plantModel.name = json["name"].string
        plantModel.kit_name = json["name"].string
        plantModel.plant_description = json["name"].string
        plantModel.price = json["price"].int
        plantModel.period = json["period"].int
        plantModel.difficurty = json["difficurty"].int
        plantModel.season_from = json["season_from"].int
        plantModel.season_to = json["season_to"].int
        if let tmpArr = json["temperatures"].array{
            for obj in tmpArr {
                let temperature = Temperature()
                temperature.id = obj["id"].int
                temperature.name = obj["name"].string
                temperature.value = obj["value"].int
                plantModel.temperatures?.append(temperature)
            }
        }
        if let tmpArr = json["waters"].array{
            for obj in tmpArr {
                let water = Water()
                water.id = obj["id"].int
                water.name = obj["name"].string
                water.value = obj["value"].int
                plantModel.waters?.append(water)
            }
        }

        return plantModel
    }
}
