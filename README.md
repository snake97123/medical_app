# アプリケーション名
お薬相談室

# アプリケーションの目的
薬剤師として患者さまに服薬指導をしていく中で、子どもの薬の飲み方や過ごし方に関して質問を受けることが多かったです。<br>
そのため、お互いにちょっとしたことを聞くことができるよううなアプリがあるといいのではないかと考えました。<br>
**→アプリ内に情報ページや質問投稿ページを作成することによって解決してもらいます。**<br>
情報の蓄積<br>
**→回答される内容が増えるにつれて情報が多くなってきます。**

# 工夫した点
薬剤師として働いている中で改善できたらいいところを考えるようにしました。<br>
実際にどのような機能があったらいいかを聞きました。<br>
薬ののみ方に関する情報詳細ページではみたい情報のみボタンを押すことによって表示されるようにしました。<br>
見た目をシンプルにすることを意識しました。

# 本番環境

**ブラウザでログイン**<br>
[http://3.114.15.180/](http://3.114.15.180/)

**質問用アカウント**<br>
メールアドレス: demo1@com<br>
パスワード: demo1234

**回答用アカウント**<br>
メールアドレス: demo2@com<br>
パスワード: demo5678

**ゲストログイン機能**<br>
ゲストログイン（閲覧用）をクリックすればログインすることが可能になります。

# 今後の改善箇所
1. 情報ページの内容を増やしていきます。
2. 近隣薬局などの検索ページを作成していきます。
3. 解決機能の実装を行っていきます。



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
![ユーザー登録画面](https://i.gyazo.com/c6b662cd808b0c45c13f5a2903d66af2.png)
![ログイン画面](https://i.gyazo.com/a96d88efc27767fdecaf17324b4b45fb.png)
 ユーザー登録を行うことが可能になります。
 ユーザー登録を行っていればログインすることが可能になります。

 # ②質問投稿機能
![質問投稿機能](https://i.gyazo.com/8c18863a21f9a2af20c0fbb357a3496d.png)
ログインすることで、質問を投稿することが可能になります。<br>
質問は編集、削除を行うことが可能です。
 # ③質問回答機能
![質問回答機能](https://i.gyazo.com/1671e49857fddc3f62885935994366ec.png)
ログインすることで、回答をすることが可能になります。<br>
回答は編集・削除することが可能です。
 # ④薬の飲み方情報詳細ページ
![服用方法詳細ページ](https://i.gyazo.com/0bb4150c60951b450fcfae36c7587219.png)
![服用方法詳細ページ](https://i.gyazo.com/02199d854a890005ffbfb9dbf23acaa0.png)
それぞれのボタンをクリックすることによってみたい情報が表示されるようになります。

# ⑤検索機能
![質問検索機能](https://i.gyazo.com/647231943d6ff6471402a52b96931bfd.jpg)
投稿フォームに入力することによって、検索をすることが可能になります。<br>
ページネーション機能を実装しています。



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
| title              | string      | null: false                                   |                
| content            | string      | null: false                                   |
| user               | reference   | null: false, foreign_key: true                |

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