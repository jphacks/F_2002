
# おしゃべじたぶる（iOS）
サーバサイドのソースコードはこちらのリポジトリ[jphacks/F_2002_1](https://github.com/jphacks/F_2002_1)をご参照ください。  

<img src="https://user-images.githubusercontent.com/29503528/98431211-a2c81f80-20f6-11eb-9308-4246c8d84f80.png" width=100%>

## デモ動画
- [モーショングラフィックス](https://youtu.be/eXhnjGchSgs)
- [プロモーションビデオ](https://youtu.be/H4oIfGaRlRs)

## 製品概要
農業 x Tech
### 背景(製品開発のきっかけ、課題等）
弊チームではアイデアソンを通じて「アグリテック」分野に挑戦してみたいということになりました。
理由としては
- コロナ化で家庭菜園のブームがあるため、ニーズが増えている
- 他の案だと既にデジタル化したものをデジタル化することになるが、家庭菜園のテックは新しいデジタルであり、クロステックになる
- メンバーの1人の実家が種苗店のため、農業に関するリソースと知見がある
- メンバーの技能それぞれを生かし、IoTやアプリなど、複合的な技術で制作ができる

というものが挙げられました。

実際に調査やヒアリングをしていく中で、需要があることを確認しました。
そこで伺った課題、続かない理由としては
- 水やりの適切な量、タイミングがわからない、忘れてしまう。
- 植物の知識がないので、良い日当たりや病気などがわからず枯らしてしまう
- 飽きてしまい続かない
が挙げられ、これらはIoTとチャット機能で解決できると判断しました。

また、水耕栽培を行うやさい物語のような、IoT家庭栽培の競合は少数確かに存在していましたが、水耕に限定されていることと、
どれも無機質で「おしゃべりができる」ことによって植物を身近に感じるサービスはありませんでした。

しかし、無機質を好むような本当に合理的な人であれば育てず野菜を購入する場合が多いのではないでしょうか。
私たち「おしゃべじたぶる」は機能的であるのみならず、本来無駄であるはずの雑談を通して野菜を身近に感じてもらう、それが家庭菜園の醍醐味であり、継続に繋がると考えました。

### 製品説明（具体的な製品の説明）

「おしゃべじたぶる」は野菜とおしゃべりしながら、家庭菜園を楽しめるスマホアプリです。  
栽培キットの購入から野菜として収穫するまで、必要な全ての工程をアプリがサポートします。  
栽培中はチャット画面から野菜とおしゃべりできるだけでなく、水やりや日光に当てるといったアドバイスもしてくれるため、事前知識のない方でも安心です。  
可愛いキャラクターとUIデザインにより、子供と一緒に育てる保護者や若い女性におすすめです。

### 特長
#### 1　キャラクター
野菜ごとに親近感を持つ、仲良くなるために必要なキャラ付けを行い、セリフ回しに特徴が出るようにしました。キャラクターはどれもオリジナルです。
暖かみがあるカラーリングで制作しました。
#### 2　栽培キットの購入
栽培に必要なセットが盛り込まれたキットを簡単に購入できます。
#### 3　チャット
難解な言葉を使わず、仲良くなることをメインに雑談やアラートなどを行います。
カメラを使って、葉っぱなどの写真を撮影すると病気について診断し、適切な助言をします。
#### 4　IoT
気温や水分量をセンサーで計測し、データを蓄積します。十分な育成環境から規定値を下回ったり、上回ったりした場合、チャットからアラートを呼びかけます。

### 解決出来ること
- 家庭菜園に関する知識や経験が身につく
- 家庭菜園に興味はあるが続けられない人のモチベーションを維持できる

### 今後の展望
- このアプリで実際に育成しきれるか実験する
- 栽培キット配送サービスとの連携
- 病気・栄養不足といった診断機能の充実
- 野菜の種類を増やし、育成の選択肢を増やす
- チャット機能への文言追加

### 注力したこと（こだわり等）
- デザインチームはデザインがずれることを懸念して、アイデアが決まった段階でサービスの認識をすり合わせ、カラーやフォント、サイズなどのデザイントーンを統一し、作業に落とし込みました。UIUX、デザインスタイルはヒアリングを元に、刺さるものを考案し制作した。
- iOSチームはデザインチームからの要件を可能な限り満たせるように実装しました。
- サーバーチームはOpenAPI を利用して仕様を共有し、Clean Architecture でテストしやすい実装をしました。また、モブプログラミングも採用しました。さらに、GitHub Actions を利用して、テスト、デプロイを自動化しました。
- また、開発全体ではDiscordを用いて各チームと素早く情報共有できるようにしました。
  
さらに詳しい情報は[発表資料](https://docs.google.com/presentation/d/13iaOR-fD3DBfOAS06PP9HBRrHrt1RHAH9nM_f6ilguU/edit?usp=sharing)をご覧ください。  

## 開発技術

### 活用した技術
#### デザイン・動画制作
- アイデアソン: [Miro](https://miro.com/app/board/o9J_khlVPbg=/)
- デザインスタイルガイドとUIデザイン: [Figma](https://www.figma.com/file/MMyBJ2hDuRvYvxwRzm39d1/test?node-id=0%3A1)
- Adobe Illustrator（キャラクター、グラフィックの作成）
- Adobe Photoshop（素材加工）
- Adobe Premire Pro（動画編集・加工）
- Adobe After Efect（モーショングラフィックの作成）

#### iOS
- xcode 12.1/swift
  - [Alamofire](https://github.com/Alamofire/Alamofire)
  - [messagekit](https://github.com/MessageKit/MessageKit)
  - [ActionSheetPicker-3.0](https://github.com/skywinder/ActionSheetPicker-3.0)

#### Server
- [go v1.15.2](https://golang.org/)
  - [echo/v4](https://github.com/labstack/echo)
  - [gorm](https://github.com/go-gorm/gorm)
  - [realize](https://github.com/oxequa/realize)
- [TypeScript](https://www.typescriptlang.org/)
  - [NestJS](https://docs.nestjs.com/)
- APIドキュメント: [OpenAPI v3.0.0](https://swagger.io/specification/)
- モックサーバー: [Postman](https://www.postman.com/)
- データベース: [MySQL v8.0](https://www.mysql.com/)
- コンテナオーケストレータ: [Docker Compose v3](https://docs.docker.com/compose/)
- mBaaS 認証・認可基盤： [Firebase Authentication](https://firebase.google.com/docs/auth)
- mBaaS DB基盤： [Firebase Realtime Database](https://firebase.google.com/docs/database)
- パブリッククラウド: [AWS EC2](https://aws.amazon.com/jp/ec2)
- CI/CD： [GitHub Actions](https://github.com/features/actions)

#### デバイス

- [Raspberry Pi](https://www.raspberrypi.org/)
- [インフィニオン テクノロジーズ](https://www.infineon.com/cms/jp/)様からの提供デバイス
  - [気圧センサーDPS310](https://github.com/Infineon/DPS310-Pressure-Sensor)
  - [MEMSマイクIM69D130](https://github.com/Infineon/IM69D130-Microphone-Shield2Go)
  - [PSoC 6 BLE Prototyping Kit (CY8CPROTO-063-BLE)](https://www.cypress.com/documentation/development-kitsboards/psoc-6-ble-prototyping-kit-cy8cproto-063-ble)
  

### 独自技術

#### ハッカソンで開発した独自機能・技術

- GitHub Actions を利用して自動でテスト、デプロイできるようにした
- OpenAPI を利用してAPI の仕様の共有を行った
- Clean Architecture をもとに、テストしやすいディレクトリ構成で実装した

#### 製品に取り入れた研究内容（データ・ソフトウェアなど）（※アカデミック部門の場合のみ提出必須）
- なし

#### 事前開発プロダクト
- なし
