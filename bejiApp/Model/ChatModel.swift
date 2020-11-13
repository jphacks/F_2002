//
//  ChatModel.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/11.
//

import Foundation

class ChatModel {
    var type: BejiMock
    
    init(type: BejiMock) {
        self.type = type
    }
    enum userMessage: String {
        case water = "水の様子はどうかな"
        case disease = "病気か知りたいな"
        case nutrition = "栄養は足りてる？"
        case tuuhi = "追肥の時期かな"
        case temperature = "温度はどうかな"
        case daily = "日当たりはどう？"
        case conversation = "おしゃべりしよう"
    }
    private var userMessages: [userMessage] = [.water,.disease,.nutrition,.tuuhi,.temperature,.daily,.conversation]
    var userMessageString: [String] { userMessages.map { $0.rawValue} }
    
    func replayMessage(userMessage: userMessage) -> String {
        switch userMessage {
            case .water: return messageWater()
            case .disease: return messageStatus()
            case .nutrition: return messageNutri()
            case .tuuhi: return messageTuihi()
            case .temperature: return messageTem()
            case .daily: return messageSun()
            case .conversation: return messageFree()
        }
    }
    
    func messageWater () -> String {
        switch type {
            case .ichigo: return "ベリー、お水欲しいな…"
            case.jyagaimo: return "水が欲しいも"
                
            case.kyuuri: return "水がほしいきゅ"
                
            case .nasu: return "やぁ！！！水が！欲しいよ！！"
                
            case .ninjin: return "水、ほしい"
                
            case .tamanegi: return "おみず、ほしいかも！"
        }
    }
    func messageStatus () -> String {
        switch type {
            case .ichigo: return "ベリー、スリーサイズ知りたい♡写真撮って見せて♡"
            case .jyagaimo: return "僕も健康診断したいも。写真撮って送ってくれないも？"
                
            case .kyuuri: return "写真撮って欲しいきゅ！診断したいきゅ！"
                
            case .nasu: return "診察だ！！！！！！！写真を撮ってくれ！！！！！"
                
            case .ninjin: return "写真、撮って。病気、診断したい。"
                
            case .tamanegi: return "ねえねえ、写真撮ってほしいな。健康診断だよ。"
        }
    }
    func messageNutri () -> String {
        switch type {
            case .ichigo: return "良いオンナは栄養も計算するの。ベリーに栄養剤、くれる？"
            case .jyagaimo: return "お肌が大事だから栄養欲しいも。活力剤買ってくれないかなも…"
                
            case.kyuuri: return "栄養剤ほしいきゅ！"
                
            case .nasu: return "栄養が！！！ない！！！栄養剤をくれないか！！！！！"
                
            case .ninjin: return "栄養剤、欲しい。健康、良い。"
                
            case .tamanegi: return "栄養不足かも。君も気をつけてね。……栄養剤、くれたりする？"
        }
    }
    func messageTuihi() -> String{
        switch type {
            case .ichigo: return "アタシも大人になったから、追肥して欲しいな"
            case .jyagaimo: return "そろそろ栄養が欲しいも。追肥を入れてくれないも？"
                
            case.kyuuri: return "大人になったから、追肥してほしいきゅ"
                
            case .nasu: return "追肥してくれ！！！！！！！今がいい時期だ！！！！"
                
            case .ninjin: return "追肥、欲しい。"
                
            case .tamanegi: return "君でいう、成人式みたいな気持ち。追肥もらってもいい？"
        }
    }
    func messageTem() -> String {
        switch type {
            case .ichigo: return "過ごしやすいわね。"
            case.jyagaimo: return "あたたかいいも"
                
            case.kyuuri: return "きゅ！良い感じきゅ！"
                
            case .nasu: return "このくらいがいいいな！！！！"
                
            case .ninjin: return "丁度、いいよ"
                
            case .tamanegi: return "好調。良い感じだ"
        }
    }
    func messageSun() -> String {
        switch type {
            case .ichigo: return "アタシの過ごしやすいかんじだわ。"
            case.jyagaimo: return "いいかんじいも！"
                
            case.kyuuri: return "良いかんじだきゅ！"
                
            case .nasu: return "とても！！良いぞ！！！！"
                
            case .ninjin: return "暖かくて、いいかも"
                
            case .tamanegi: return "日光、良いね。"
        }
    }
    func messageFree() -> String {
        switch type {
            case .ichigo: return "アタシはもっともっと綺麗になって、あなたに綺麗な姿を見て欲しいの"
            case.jyagaimo: return "ボクを鉢植えで育てるなんて、変わってるもな〜"
                
            case.kyuuri: return "きゅきゅきゅ！今日は何するきゅ？"
                
            case .nasu: return "俺がうるさい？！！！！！そんなことないだろ！！！！！"
                
            case .ninjin: return "喋り方、ヘン？自由、俺の……"
                
            case .tamanegi: return "国語算数理科社会。学校、楽しかった？"
        }
    }
    
}
