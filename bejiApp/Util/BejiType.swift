//
//  BejiType.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation
import UIKit

public enum BejiType {
    case tamanegi
    case ninjin
    case nasu
    case jyagaimo
    case ichigo
    case kyuuri
    
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
            case .ichigo: return UIImage(imageLiteralResourceName: "いちご購入")
            case.jyagaimo: return UIImage(imageLiteralResourceName: "じゃがいも購入")

            case.kyuuri: return UIImage(imageLiteralResourceName: "きゅうり購入")

            case .nasu: return UIImage(imageLiteralResourceName: "なす購入")

            case .ninjin: return UIImage(imageLiteralResourceName: "にんじん購入")

            case .tamanegi: return UIImage(imageLiteralResourceName: "タマネギ購入")

        }
    }
    
}
