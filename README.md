# アプリケーション名
お薬相談室

# アプリケーションの目的
薬剤師で仕事をしている時に子供の薬の飲み方になどに関して相談を受けることが多かったです。<br>
**→情報ページや質問投稿ページを作成することによって解決してもらう。**<br>
情報の蓄積<br>
**→回答される内容が増えるにつれて情報が多くなってくる。**

# 工夫した点
薬剤師として働いている中で改善できたらいいところを考えるようにしました。<br>
実際にどのような機能があったらいいかを聞きました。<br>
薬ののみ方に関する情報詳細ページではみたい情報のみボタンを押すことによって表示されるようにしました。

# 本番環境

**ブラウザでログイン**<br>
[http://3.114.15.180/](http://3.114.15.180/)

**質問用アカウント**<br>
メールアドレス: demo1@com<br>
パスワード: demo1234

**回答用アカウント**<br>
メールアドレス: demo2@com<br>
パスワード: demo5678

# 今後の改善箇所
1. 検索機能を実装し探しやすいようにします。
2. 情報ページの内容を増やしていきます。
3. 問題解決機能を実装します。

# 本アプリケーションの注意点
本当に専門的なことで困っている場合には薬剤師や医師に相談してもらうようにする必要があります。

# 開発環境
 Ruby 2.6.5 <br>
 Ruby on Rails 6.0.0 <br>
 HTML/CSS <br>
 Javascript <br>
 MySQl2 0.4.4 <br>
 VS Code<br>
 AWS(EC2)<br>


 # ①ユーザー登録詳細画面
![ユーザー登録画面](https://i.gyazo.com/8fdc871f3555e91d9a8f04dee4e718c2.jpg)
![ログイン画面](https://i.gyazo.com/7a85c9b4c76582b69f4c2bfd84abb322.jpg)
 ユーザー登録を行うことが可能になります。
 ユーザー登録を行っていればログインすることが可能になります。

 # ②質問投稿機能
![質問投稿機能](https://i.gyazo.com/e945e6b349e6823dc12f216b74d72da0.jpg)
ログインすることで、質問を投稿することが可能になります。
質問は編集、削除を行うことが可能です。
 # ③質問回答機能
![質問回答機能](https://i.gyazo.com/f617bece08c66bd9d47800611bf78200.jpg)
ログインすることで、回答をすることが可能になります。
回答は編集・削除することが可能です。
 # ④薬の飲み方情報詳細ページ
![服用方法詳細ページ](https://i.gyazo.com/104db986fe08710f20101e5340fd48e2.png)
![服用方法詳細ページ](https://i.gyazo.com/86ac274de78f0ea3ff21cd98e0596c93.png)
それぞれのボタンをクリックすることによってみたい情報が表示されるようになります。


# テーブル設計

## Users テーブル

|  Column             |  Type       |  Options                   |
| ------------------- | ----------- | -------------------------- |
|  nickname           | string      | null: false                |
|  email              | string      | null: false ,  unique:true |
|  password           | string      | null: false                |
|  phone_number       | string      | null: false 

### Association
has_many questions<br>
has_many answers

## Questions テーブル

|  Column            |  Type       |  Options                                      |
| ------------------ | ------------| --------------------------------------------- |
| title              | string       | null: false                                  |                
| content            | string       | null: false                                  |
| user               | reference    | null: false, foreign_key: true               |

### Association
belongs_to user<br>
has_many answers



## Answers テーブル

|  Column            |  Type       |  Options                                      |
| ------------------ | ----------- | --------------------------------------------- |
| text               | string      | null: false                                   |
| user               | reference   | null: false,  foreign_key:  true              |
| question           | reference   | null: false,  foreign_key:  true              |

### Association 
belongs_to user<br>
belongs_to question