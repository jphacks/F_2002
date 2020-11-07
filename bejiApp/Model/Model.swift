//
//  Model.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation
import Firebase

struct UserModel: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var user_plants: String?
}

class PlantModel: Codable {
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

class Temperature: Codable {
    var id: Int?
    var name: String?
    var value: Int?
}

class Water: Codable {
    var id: Int?
    var name: String?
    var value: Int?
}

struct Viewdata{
    var token: String?
    var type: BejiType = .ichigo
}

public struct NewModel: Codable {
    public let id: Int
    public struct CreatedAt: Codable {
    }
    public let createdAt: CreatedAt
    public struct UpdatedAt: Codable {
    }
    public let updatedAt: UpdatedAt
    public struct DeletedAt: Codable {
    }
    public let deletedAt: DeletedAt
    public struct Plant: Codable {
        public let id: Int
        public struct CreatedAt: Codable {
        }
        public let createdAt: CreatedAt
        public struct UpdatedAt: Codable {
        }
        public let updatedAt: UpdatedAt
        public struct DeletedAt: Codable {
        }
        public let deletedAt: DeletedAt
        public let name: String
        public let nickName: String
        public let price: Int
        public let period: Int
        public let difficulty: Int
        public let description: String
        public let kitName: String
        public struct Season: Codable {
            public let from: Int
            public let to: Int
        }
        public let season: Season
        public struct Temperature: Codable {
            public let id: Int
            public let name: String
            public let value: Double
        }
        public let temperatures: [Temperature]
        public struct Water: Codable {
            public let id: Int
            public let name: String
            public let value: Int
        }
        public let waters: [Water]
        private enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case deletedAt = "deleted_at"
            case name
            case nickName = "nick_name"
            case price
            case period
            case difficulty
            case description
            case kitName = "kit_name"
            case season
            case temperatures
            case waters
        }
    }
    public let plant: Plant
    public let nickName: String
    public struct StartCultivatingAt: Codable {
    }
    public let startCultivatingAt: StartCultivatingAt
    public struct FinishCultivatingAt: Codable {
    }
    public let finishCultivatingAt: FinishCultivatingAt
    public struct Rerord: Codable {
        public struct Watering: Codable {
            public let id: Int
            public struct CreatedAt: Codable {
            }
            public let createdAt: CreatedAt
            public struct UpdatedAt: Codable {
            }
            public let updatedAt: UpdatedAt
            public struct DeletedAt: Codable {
            }
            public let deletedAt: DeletedAt
            private enum CodingKeys: String, CodingKey {
                case id
                case createdAt = "created_at"
                case updatedAt = "updated_at"
                case deletedAt = "deleted_at"
            }
        }
        public let waterings: [Watering]
        public struct Harvesing: Codable {
            public let id: Int
            public struct CreatedAt: Codable {
            }
            public let createdAt: CreatedAt
            public struct UpdatedAt: Codable {
            }
            public let updatedAt: UpdatedAt
            public struct DeletedAt: Codable {
            }
            public let deletedAt: DeletedAt
            private enum CodingKeys: String, CodingKey {
                case id
                case createdAt = "created_at"
                case updatedAt = "updated_at"
                case deletedAt = "deleted_at"
            }
        }
        public let harvesings: [Harvesing]
    }
    public let rerord: Rerord
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case plant
        case nickName = "nick_name"
        case startCultivatingAt = "start_cultivating_at"
        case finishCultivatingAt = "finish_cultivating_at"
        case rerord
    }
}
