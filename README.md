
 # おしゃべじたぶる(iOS)
こちらのリポジトリはフロント（iOS）部分のみのリポジトリになります
サーバーサイドのソースコード及び製品コード共有してあるメインリポジトリはこちら[jphacks/F_2002_1](https://github.com/jphacks/F_2002_1)をご参照ください。  

## Development

You can develop bejiApp

### Environment

- Xcode: 12.2
- Swift: 5.3.1

### Configuration

- UI implementation: Storyboard + XIB
- Architecture: MVVM + RxSwift
- CI: DeployaGate(https://deploygate.com/)

### Setup

1. Clone the project.

```
$ git clone https://github.com/ikemoti/bejiApp
$ cd bejiApp
```

3. Run `make setup` .  
```pod
pod update
```
## 依存ライブラリ
 - [Alamofire](https://github.com/Alamofire/Alamofire)
 - [messagekit](https://github.com/MessageKit/MessageKit)
 - [ActionSheetPicker-3.0](https://github.com/skywinder/ActionSheetPicker-3.0)
 
## Contribution

I would be happy if you contribute :)

- [New issue](https://github.com/ikemoti/bejiApp/issues/new)
- [New pull request](https://github.com/ikemoti/bejiApp/compare)
