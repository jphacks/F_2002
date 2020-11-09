
# おしゃべじたぶる（iOS）
こちらのリポジトリはフロント（iOS）部分のみのリポジトリになります
サーバーサイドのソースコード及び製品コード共有してあるメインリポジトリはこちら[jphacks/F_2002_1](https://github.com/jphacks/F_2002_1)をご参照ください。  

<img src="https://user-images.githubusercontent.com/29503528/98431211-a2c81f80-20f6-11eb-9308-4246c8d84f80.png" width=100%>


# README (iOS用)
## 審査員のかたへ
### コードフリーズ時に説明資料用に利用したコードを誤って提出してしまった為masterブランチにいくつか修正点をコミットしています



## インストール/ビルド
- xcode 12.1/swift
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
 - [Alamofire](https://github.com/Alamofire/Alamofire)
 - [messagekit](https://github.com/MessageKit/MessageKit)
 - [ActionSheetPicker-3.0](https://github.com/skywinder/ActionSheetPicker-3.0)
