#  README

## インストール/ビルド

```pod
pod update
```

> 本Appはデモ動画作成の為iPhone11 Proの規格に調整しておりシュミレーターで起動する際はご注意ください

##  Architecture
> 本AppはMVCで実装されています


## bejiApp

メインバンドルです。  
アプリケーションの細かい実装 / 内容について記載します。

## [Util]

全バンドルから参照される、ユーティリティなソースの集合です。  

## [Infra]
通信周りの処理・ロジックを記載


## [Model]
通信に利用する構造体を記載


## [View]

UIとUIni使用するロジックを記載
UIに関してはstoryBoard + コードレイアウトで実装しています

/StartVC
初期画面

/SignUpVC
ユーザー登録画面

/SelectVC
植物選択画面

/PurchaceVC
購入画面

/PlantVC
植物デフォルト画面

/ChatVC
チャット画面

## 依存ライブラリ
swiftPM
・Alamofire
・MessageKit
・InputBarAccessoryView
・SwiftyJSON


cocoaPods
・pod 'ActionSheetPicker-3.0'
・pod 'Firebase/Core'
・pod 'Firebase/Database'
・pod 'Firebase/Auth'
・pod "Firebase/Storage"
・pod 'R.swift'

