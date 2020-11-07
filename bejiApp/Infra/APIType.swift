//
//  APIType.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

//import Foundation
//
//let Domain = "https://e3c902a3-9f7d-4f1c-9b9a-daa5e4633165.mock.pstmn.io"
//
//public protocol TargetType {
//    var domain: String { get }
//    var path: String { get }
//    var method: String { get }
//}
//
//// 実行されるAPIの種類を管理
//public enum API {
//    case users
//    case plants
//    case userPlants
//    case user(Int)
//    case userChange(Int)
//    case userDelete(Int)
//    case plant(Int)
//    case profile(Int)
//    case userPlant(Int)
//    case userPlantChange(Int)
//    case userPlantDelete(Int)
//    case plantWatering(Int)
//}
//
//extension API: TargetType {
//    public var domain : String {
//        return Domain
//    }
//    
//    public var path : String {
//        switch self {
//            case .users:
//                return "\(domain)" + "/users"
//            case .plants:
//                return "\(domain)" + "/plants"
//            case .userPlants:
//                return "\(domain)" + "/user/cultivations"
//            case .user:
//                return "\(domain)" + "/user"
//            case .userChange:
//                return "\(domain)" + "/user"
//            case .userDelete:
//                return "\(domain)" + "/user"
//            case .plant(let plantId):
//                return "\(domain)" + "/plants/\(plantId)"
//            case .profile(let userId):
//                return "\(domain)" + "/users/\(userId)"
//            case .userPlant(let plantId):
//                return "\(domain)" + "/user/cultivations/\(plantId)"
//            case .userPlantChange(let plantId):
//                return "\(domain)" + "/user/cultivations/\(plantId)"
//            case .userPlantDelete(let plantId):
//                return "\(domain)" + "/user/cultivations/\(plantId)"
//            case .plantWatering(let plantId):
//                return "\(domain)" + "/user/cultivations/\(plantId)/watering"
//        }
//    }
//    
//    public var method: String {
//        switch self {
//            case .users:
//                return "POST"
//            case .plants:
//                return "GET"
//            case .user:
//                return "GET"
//            case .userChange:
//                return "PUT"
//            case .userDelete:
//                return "DELETE"
//            case .plant:
//                return "GET"
//            case .profile:
//                return "GET"
//            case .userPlants:
//                return "GET"
//            case .userPlant:
//                return "GET"
//            case .userPlantChange:
//                return "PUT"
//            case .userPlantDelete:
//                return "DELETE"
//            case .plantWatering:
//                return "POST"
//        }
//    }
//}
