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
            case.jyagaimo: return 2
                
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
    func messageWater () -> String {
        switch self {
            case .ichigo: return "ベリー、お水欲しいな…"
            case.jyagaimo: return "水が欲しいも"
                
            case.kyuuri: return "水がほしいきゅ"
                
            case .nasu: return "やぁ！！！水が！欲しいよ！！"
                
            case .ninjin: return "水、ほしい"
                
            case .tamanegi: return "おみず、ほしいかも！"
        }
    }
    func messageStatus () -> String {
        switch self {
            case .ichigo: return "ベリー、スリーサイズ知りたい♡写真撮って見せて♡"
            case.jyagaimo: return "僕も健康診断したいも。写真撮って送ってくれないも？"
                
            case.kyuuri: return "写真撮って欲しいきゅ！診断したいきゅ！"
                
            case .nasu: return "診察だ！！！！！！！写真を撮ってくれ！！！！！"
                
            case .ninjin: return "写真、撮って。病気、診断したい。"
                
            case .tamanegi: return "ねえねえ、写真撮ってほしいな。健康診断だよ。"
        }
    }
    func messageNutri () -> String {
        switch self {
            case .ichigo: return "良いオンナは栄養も計算するの。ベリーに栄養剤、くれる？"
            case.jyagaimo: return "お肌が大事だから栄養欲しいも。活力剤買ってくれないかなも…"
                
            case.kyuuri: return "栄養剤ほしいきゅ！"
                
            case .nasu: return "栄養が！！！ない！！！栄養剤をくれないか！！！！！"
                
            case .ninjin: return "栄養剤、欲しい。健康、良い。"
                
            case .tamanegi: return "栄養不足かも。君も気をつけてね。……栄養剤、くれたりする？"
        }
    }
    func messageTuihi() -> String{
        switch self {
            case .ichigo: return "アタシも大人になったから、追肥して欲しいな"
            case.jyagaimo: return "そろそろ栄養が欲しいも。追肥を入れてくれないも？"
                
            case.kyuuri: return "大人になったから、追肥してほしいきゅ"
                
            case .nasu: return "追肥してくれ！！！！！！！今がいい時期だ！！！！"
                
            case .ninjin: return "追肥、欲しい。"
                
            case .tamanegi: return "君でいう、成人式みたいな気持ち。追肥もらってもいい？"
        }
    }
    func messageTem() -> String {
        switch self {
            case .ichigo: return "過ごしやすいわね。"
            case.jyagaimo: return "あたたかいいも"
                
            case.kyuuri: return "きゅ！良い感じきゅ！"
                
            case .nasu: return "このくらいがいいいな！！！！"
                
            case .ninjin: return "丁度、いいよ"
                
            case .tamanegi: return "好調。良い感じだ"
        }
    }
    func messageSun() -> String {
        switch self {
            case .ichigo: return "アタシの過ごしやすいかんじだわ。"
            case.jyagaimo: return "いいかんじいも！"
                
            case.kyuuri: return "良いかんじだきゅ！"
                
            case .nasu: return "とても！！良いぞ！！！！"
                
            case .ninjin: return "暖かくて、いいかも"
                
            case .tamanegi: return "日光、良いね。"
        }
    }
    func messageFree() -> String {
        switch self {
            case .ichigo: return "アタシはもっともっと綺麗になって、あなたに綺麗な姿を見て欲しいの"
            case.jyagaimo: return "ボクを鉢植えで育てるなんて、変わってるもな〜"
                
            case.kyuuri: return "きゅきゅきゅ！今日は何するきゅ？"
                
            case .nasu: return "俺がうるさい？！！！！！そんなことないだろ！！！！！"
                
            case .ninjin: return "喋り方、ヘン？自由、俺の……"
                
            case .tamanegi: return "国語算数理科社会。学校、楽しかった？"
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


