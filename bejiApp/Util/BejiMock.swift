//
//  BejiType.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation
import UIKit

public enum BejiMock: String {
    case tamanegi = "タマネギ"
    case ninjin = "にんじん"
    case nasu = "なす"
    case jyagaimo = "じゃがいも"
    case ichigo = "いちご"
    case kyuuri = "きゅうり"
    func id() -> Int {
        switch self {
        case .ichigo:
            return 3
        case .jyagaimo:
            return 2
        case .kyuuri:
            return 6
        case .nasu:
            return 4
        case .ninjin:
            return 7
        case .tamanegi:
            return 5
        }
    }
    var chatName: String {
        switch self {
        case .ichigo:
            return "strawberry"
        case .jyagaimo:
            return "potato"
        case .kyuuri:
            return "cucumber"
        case .nasu:
            return "eggplants"
        case .ninjin:
            return "carrot"
        case .tamanegi:
            return "onion"
        }
    }
    var nameImage: UIImage {
        switch self {
        case .ichigo:
            return R.image.plate.strawberryPlate()!
        case.jyagaimo:
            return R.image.plate.potatoPlate()!
        case .kyuuri:
            return R.image.plate.cucumberPlate()!
        case .nasu:
            return R.image.plate.eggplantsPlate()!
        case .ninjin:
            return R.image.plate.carrotPlate()!
        case .tamanegi:
            return R.image.plate.onionPlate()!
        }
    }
    var purchaceImage: UIImage {
        switch self {
        case .ichigo:
            return R.image.backGround.strawberryBackground()!
        case .jyagaimo:
            return R.image.backGround.potatoBackground()!
        case .kyuuri:
            return R.image.backGround.cucumberBackground()!
        case .nasu:
            return R.image.backGround.eggplantBackground()!
        case .ninjin:
            return R.image.backGround.carrotBackground()!
        case .tamanegi:
            return R.image.backGround.onionBackground()!
        }
    }
    var buttonImage: UIImage {
        switch self {
        case .ichigo:
            return R.image.button.selectStrawberry()!
        case .jyagaimo:
            return R.image.button.selectPotato()!
        case .kyuuri:
            return R.image.button.selectCucumber()!
        case .nasu:
            return R.image.button.selectEgplant()!
        case .ninjin:
            return R.image.button.selectCarrot()!
        case .tamanegi:
            return R.image.button.selectOnion()!
        }
    }
    var name: String {
        switch self {
        case .ichigo:
            return "いちごくん"
        case .jyagaimo:
            return "じゃがいもくん"
        case.kyuuri:
            return "きゅうりくん"
        case .nasu:
            return "なすくん"
        case .ninjin:
            return "にんじんくん"
        case .tamanegi:
            return "タマネギくん"
        }
    }
    var icon: UIImage {
        switch self {
        case .ichigo:
            return R.image.icon.straberryIcon()!
        case.jyagaimo:
            return R.image.icon.potatoIcon()!
        case.kyuuri:
            return R.image.icon.cucumberIcon()!
        case .nasu:
            return R.image.icon.eggPlantsIcon()!
        case .ninjin:
            return R.image.icon.carrotIcon()!
        case .tamanegi:
            return R.image.icon.onionIcon()!
        }
    }
    var chatbackground: UIImage {
        switch self {
        case .ichigo:
            return R.image.backGround.strawberryChatBackground()!
        case .jyagaimo:
            return R.image.backGround.potatoChatBackground()!
        case .kyuuri:
            return R.image.backGround.cucumberChatBackGround()!
        case .nasu:
            return R.image.backGround.eggplantChatBackground()!
        case .ninjin:
            return R.image.backGround.carrotChatBackground()!
        case .tamanegi:
            return R.image.backGround.onionChatBackground()!
        }
    }
    var getIcon: UIImage {
        switch self {
        case .ichigo:
            return R.image.icon.straberryIcon()!
        case .jyagaimo:
            return R.image.icon.potatoIcon()!
        case .kyuuri:
            return R.image.icon.cucumberIcon()!
        case .nasu:
            return R.image.icon.eggPlantsIcon()!
        case .ninjin:
            return R.image.icon.carrotIcon()!
        case .tamanegi:
            return R.image.icon.onionIcon()!
        }
    }
    var plant: UIImage {
        switch self {
        case .ichigo:
            return R.image.plantsPot.nomal.nomalStrawberry()!
        case .jyagaimo:
            return  R.image.plantsPot.nomal.nomalPotato()!
        case .kyuuri:
            return R.image.plantsPot.nomal.nomaluCunber()!
        case .nasu:
            return R.image.plantsPot.nomal.nomalEggplants()!
        case .ninjin:
            return R.image.plantsPot.nomal.nomalCarrot()!
        case .tamanegi:
            return R.image.plantsPot.nomal.nomalOnion()!
        }
    }
    var glowth: UIImage {
        switch self {
        case .ichigo:
            return R.image.plantsPot.growth.growthStrawberry()!
        case.jyagaimo:
            return R.image.plantsPot.growth.growthPotato()!
        case.kyuuri:
            return R.image.plantsPot.growth.growthCucumber()!
        case .nasu:
            return R.image.plantsPot.growth.growthEggplants()!
        case .ninjin:
            return R.image.plantsPot.growth.growthCarot()!
        case .tamanegi:
            return R.image.plantsPot.growth.growthOnion()!
        }
    }
    var iotGoodStatus: String {
        switch self {
        case .ichigo:
            return "今日のアタシ、輝いてる"
        case .jyagaimo:
            return "元気だいも！"
        case.kyuuri:
            return "元気きゅきゅ！"
        case .nasu:
            return "俺は！！！！！元気だ！！"
        case .ninjin:
            return "健康、元気だよ。"
        case .tamanegi:
            return "元気、楽しい"
        }
    }
    var iotBadStatushumidity: String {
        switch self {
        case .ichigo:
                return "どういうつもりかしら"
        case .jyagaimo:
                return "ここ、ちょっと困るいも"
        case.kyuuri:
                return "パサパサするきゅ"
        case .nasu:
                return "ここは生きづらい！"
        case .ninjin:
                return "湿気、体が…"
        case .tamanegi:
                return "乾燥、大敵。"
        }
    }
    var iotBadStatusWater: String {
        switch self {
        case .ichigo:
            return "あら…水が…"
        case .jyagaimo:
            return "お水の調子良くないいも"
        case.kyuuri:
            return "パサパサするきゅ"
        case .nasu:
            return "水が危ないぜ……"
        case .ninjin:
            return "お水、様子が…"
        case .tamanegi:
            return "土。よくないかも"
        }
    }
    var iotBadstatusIlluminance: String {
        switch self {
        case .ichigo:
            return "あなたも日を気にするわよね"
        case .jyagaimo:
            return "日当たり確認していも"
        case .kyuuri:
            return "明るさが気になるきゅ"
        case .nasu:
            return "日当たりみてくれるか？"
        case .ninjin:
            return "日光、調子が…"
        case .tamanegi:
            return "ううん…苦しい"
        }
    }
    var bigIcon: UIImage {
        switch self {
        case .ichigo:
            return R.image.icon.bigStraberry()!
        case .jyagaimo:
            return R.image.icon.bigPotato()!
        case .kyuuri:
            return R.image.icon.bigCuCamber()!
        case .nasu:
            return R.image.icon.bigEggPlants()!
        case .ninjin:
            return R.image.icon.bigCarrot()!
        case .tamanegi:
            return R.image.icon.bigonion()!
        }
    }
}
