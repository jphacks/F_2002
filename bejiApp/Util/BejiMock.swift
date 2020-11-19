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
            case .ichigo: return 3
            case .jyagaimo: return 2
                
            case .kyuuri: return 6
                
            case .nasu: return 4
                
            case .ninjin: return 7
                
            case .tamanegi: return 5
        }
    }
    var chatName: String {
        switch self {
            case .ichigo: return "strawberry"
            case .jyagaimo: return "potato"
                
            case .kyuuri: return "cucumber"
                
            case .nasu: return "eggplants"
                
            case .ninjin: return "carrot"
                
            case .tamanegi: return "onion"
            
            
            
            
        }
    }
    
    func nameImage() -> UIImage {
        switch self {
            case .ichigo: return R.image.plate.strawberryPlate()!
            case.jyagaimo: return R.image.plate.potatoPlate()!
                
            case.kyuuri: return R.image.plate.cucumberPlate()!
                
            case .nasu: return R.image.plate.eggplantsPlate()!
                
            case .ninjin: return R.image.plate.carrotPlate()!
                
            case .tamanegi: return R.image.plate.onionPlate()!
                
        }
    }
    func purchaceImage() -> UIImage{
        switch self {
            case .ichigo: return R.image.backGround.strawberryBackground()!
            case.jyagaimo: return R.image.backGround.potatoBackground()!
                
            case.kyuuri: return R.image.backGround.cucumberBackground()!
                
            case .nasu: return R.image.backGround.eggplantBackground()!
                
            case .ninjin: return R.image.backGround.carrotBackground()!
                
            case .tamanegi: return R.image.backGround.onionBackground()!
                
        }
    }
    func buttonImage() -> UIImage {
        switch self {
            case .ichigo: return R.image.button.selectStrawberry()!
            case.jyagaimo: return R.image.button.selectPotato()!
                
            case.kyuuri: return R.image.button.selectCucumber()!
                
            case .nasu: return R.image.button.selectEgplant()!
                
            case .ninjin: return R.image.button.selectCarrot()!
                
            case .tamanegi: return R.image.button.selectOnion()!
        }
    }
    func name() -> String {
        switch self {
            case .ichigo: return "いちごくん"
            case .jyagaimo: return "じゃがいもくん"
                
            case.kyuuri: return "きゅうりくん"
                
            case .nasu: return "なすくん"
                
            case .ninjin: return "にんじんくん"
                
            case .tamanegi: return "タマネギくん"
                
        }
    }
    func icon() -> UIImage {
        switch self {
            case .ichigo: return R.image.icon.straberryIcon()!
            case.jyagaimo: return R.image.icon.potatoIcon()!
                
            case.kyuuri: return R.image.icon.cucumberIcon()!
                
            case .nasu: return R.image.icon.eggPlantsIcon()!
                
            case .ninjin: return R.image.icon.carrotIcon()!
                
            case .tamanegi: return R.image.icon.onionIcon()!
                
        }
    }
    func chatbackground() -> UIImage {
        switch self {
            case .ichigo: return R.image.backGround.strawberryChatBackground()!
            case.jyagaimo: return R.image.backGround.potatoChatBackground()!
                
            case.kyuuri: return R.image.backGround.cucumberChatBackGround()!
                
            case .nasu: return R.image.backGround.eggplantChatBackground()!
            case .ninjin: return R.image.backGround.carrotChatBackground()!
                
            case .tamanegi: return R.image.backGround.onionChatBackground()!
        }
    }
    func getIcon() -> UIImage {
        switch self {
            case .ichigo: return R.image.icon.straberryIcon()!
            case.jyagaimo: return R.image.icon.potatoIcon()!
                
            case.kyuuri: return R.image.icon.cucumberIcon()!
                
            case .nasu: return R.image.icon.eggPlantsIcon()!
            case .ninjin: return R.image.icon.carrotIcon()!
                
            case .tamanegi: return R.image.icon.onionIcon()!
        }
    }
    func plant() -> UIImage {
        switch self {
            case .ichigo: return R.image.plantsPot.nomal.nomalStrawberry()!
            case.jyagaimo: return  R.image.plantsPot.nomal.nomalPotato()!
                
            case.kyuuri: return R.image.plantsPot.nomal.nomaluCunber()!
                
            case .nasu: return R.image.plantsPot.nomal.nomalEggplants()!
            case .ninjin: return R.image.plantsPot.nomal.nomalCarrot()!
                
            case .tamanegi: return R.image.plantsPot.nomal.nomalOnion()!
        }
    }
    func glowth() -> UIImage{
        switch self {
            case .ichigo: return R.image.plantsPot.growth.growthStrawberry()!
            case.jyagaimo: return R.image.plantsPot.growth.growthPotato()!
                
            case.kyuuri: return R.image.plantsPot.growth.growthCucumber()!
                
            case .nasu: return R.image.plantsPot.growth.growthEggplants()!
            case .ninjin: return R.image.plantsPot.growth.growthCarot()!
                
            case .tamanegi: return R.image.plantsPot.growth.growthOnion()!
        }
    }
    
    
}


