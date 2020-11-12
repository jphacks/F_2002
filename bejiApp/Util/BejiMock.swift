//
//  BejiType.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation
import UIKit

public enum BejiMock {
    case tamanegi
    case ninjin
    case nasu
    case jyagaimo
    case ichigo
    case kyuuri
    
    func id() -> Int {
        switch self {
            case .ichigo: return 3
            case .jyagaimo: return 2
                
            case.kyuuri: return 6
                
            case .nasu: return 4
                
            case .ninjin: return 7
                
            case .tamanegi: return 5
        }
    }
    
    func nameImage() -> UIImage {
        switch self {
            case .ichigo: return UIImage(imageLiteralResourceName: "いちご名前")
            case.jyagaimo: return UIImage(imageLiteralResourceName: "じゃがいも名前")
                
            case.kyuuri: return UIImage(imageLiteralResourceName: "きゅうり名前")
                
            case .nasu: return UIImage(imageLiteralResourceName: "なす名前")
                
            case .ninjin: return UIImage(imageLiteralResourceName: "にんじん名前")
                
            case .tamanegi: return UIImage(imageLiteralResourceName: "たまねぎ名前")
                
        }
    }
    func purchaceImage() -> UIImage{
        switch self {
            case .ichigo: return UIImage(imageLiteralResourceName: "strawberryBackground")
            case.jyagaimo: return UIImage(imageLiteralResourceName: "potatoBackground")
                
            case.kyuuri: return UIImage(imageLiteralResourceName: "cucumberbackground")
                
            case .nasu: return UIImage(imageLiteralResourceName: "egplantBackground")
                
            case .ninjin: return UIImage(imageLiteralResourceName: "carotBackground")
                
            case .tamanegi: return UIImage(imageLiteralResourceName: "onionBackground")
                
        }
    }
    func name() -> String {
        switch self {
            case .ichigo: return "いちごくん"
            case.jyagaimo: return "じゃがいもくん"
                
            case.kyuuri: return "きゅうりくん"
                
            case .nasu: return "なすくん"
                
            case .ninjin: return "にんじんくん"
                
            case .tamanegi: return "タマネギくん"
                
        }
    }
    func icon() -> UIImage {
        switch self {
            case .ichigo: return UIImage(imageLiteralResourceName: "strawberry")
            case.jyagaimo: return UIImage(imageLiteralResourceName: "potato")
                
            case.kyuuri: return UIImage(imageLiteralResourceName: "cucumber")
                
            case .nasu: return UIImage(imageLiteralResourceName: "egplant")
                
            case .ninjin: return UIImage(imageLiteralResourceName: "carot")
                
            case .tamanegi: return UIImage(imageLiteralResourceName: "onion")
                
        }
    }
    func chatbackground() -> UIImage {
        switch self {
            case .ichigo: return UIImage(imageLiteralResourceName: "いち背景")
            case.jyagaimo: return UIImage(imageLiteralResourceName: "じゃが背景")
                
            case.kyuuri: return UIImage(imageLiteralResourceName: "きゅう背景")
                
            case .nasu: return UIImage(imageLiteralResourceName: "なす背景")
            case .ninjin: return UIImage(imageLiteralResourceName: "にん背景")
                
            case .tamanegi: return UIImage(imageLiteralResourceName: "たま背景")
        }
    }
    func getIcon() -> UIImage {
        switch self {
            case .ichigo: return UIImage(imageLiteralResourceName: "いちアイコン")
            case.jyagaimo: return UIImage(imageLiteralResourceName: "じゃがアイコン")
                
            case.kyuuri: return UIImage(imageLiteralResourceName: "きゅうアイコン")
                
            case .nasu: return UIImage(imageLiteralResourceName: "なすアイコン")
            case .ninjin: return UIImage(imageLiteralResourceName: "にんアイコン")
                
            case .tamanegi: return UIImage(imageLiteralResourceName: "たまアイコン")
        }
    }
    func imageMessage() -> String {
        switch self {
            case .ichigo: return "健康診断ありがと。ちょっとお肌の調子がよくないわ…追肥してもらえるかしら。"
            case.jyagaimo: return "写真ありがとういも！診断したところ、ちょっと元気ないいも…日当たりの良いところに移動してくれるいも？"
                
            case.kyuuri: return "きゅー！！！健康診断ありがきゅ！ちょっと寒いところにいるのが辛いかもきゅ…あたたかいところに移動して欲しいキュ！"
                
            case .nasu: return "俺を！！！！撮ったな！！！！！今日はすこぶる元気だ〜！！ありがとう！！！"
                
            case .ninjin: return "健康、健康だよ。おしゃべり、したいな。"
                
            case .tamanegi: return "診断したところ、ちょっと栄養が足りてないかも…活力剤を使ってもらえるかな？"
        }
    }
    func plant() -> UIImage {
        switch self {
            case .ichigo: return UIImage(imageLiteralResourceName: "いち")
            case.jyagaimo: return UIImage(imageLiteralResourceName: "じゃが")
                
            case.kyuuri: return UIImage(imageLiteralResourceName: "きゅう")
                
            case .nasu: return UIImage(imageLiteralResourceName: "なす")
            case .ninjin: return UIImage(imageLiteralResourceName: "にん")
                
            case .tamanegi: return UIImage(imageLiteralResourceName: "たま")
        }
    }
    func glowth() -> UIImage{
        switch self {
            case .ichigo: return UIImage(imageLiteralResourceName: "成長いち")
            case.jyagaimo: return UIImage(imageLiteralResourceName: "成長じゃが")
                
            case.kyuuri: return UIImage(imageLiteralResourceName: "成長きゅう")
                
            case .nasu: return UIImage(imageLiteralResourceName: "成長なす")
            case .ninjin: return UIImage(imageLiteralResourceName: "成長にん")
                
            case .tamanegi: return UIImage(imageLiteralResourceName: "成長たま")
        }
    }
    
    
}


