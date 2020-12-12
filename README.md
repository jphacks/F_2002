
 # おしゃべじたぶる(iOS)
こちらのリポジトリはフロント（iOS）部分のみのリポジトリになります
サーバーサイドのソースコード及び製品コード共有してあるメインリポジトリはこちら[jphacks/F_2002_1](https://github.com/jphacks/F_2002_1)をご参照ください。  

![1c503524c8ea1f989a82bd45e394d926](https://user-images.githubusercontent.com/29503528/98431211-a2c81f80-20f6-11eb-9308-4246c8d84f80.png)

## Development

You can develop bejiApp

### Environment

- Xcode: 12.2
- Swift: 5.3.1

### Configuration

- UI implementation: codeLayout + XIB
- Architecture: MVVM + RxSwift
- CI: DeployaGate(https://deploygate.com/) + Bitrise

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

# Using Tools and Libraries

## Tools
- [SwiftGen](https://github.com/SwiftGen/SwiftGen)
- [SwiftLint](https://github.com/realm/SwiftLint)
- [Firebase](https://firebase.google.com/)

## Network
- [Alamofire](https://github.com/Alamofire/Alamofire)

## UI
 - [messagekit](https://github.com/MessageKit/MessageKit)
 - [ActionSheetPicker-3.0](https://github.com/skywinder/ActionSheetPicker-3.0)
 
## Contribution

I would be happy if you contribute :)

- [New issue](https://github.com/jphacks/F_2002/issues/new)
- [New pull request](https://github.com/jphacks/F_2002/compare)
