# アプリケーションの目的
薬剤師で仕事をしている時に子供の薬の飲み方になどに関して相談を受けることが多かった。
**→情報ページや質問投稿ページを作成することによって解決してもらう。**
情報の蓄積
**→回答される内容が増えるにつれて情報が多くなってくる。**

# アカウント情報

# 今後の改善箇所
1. 検索機能を実装し探しやすいようにする。
2. 情報ページの内容を増やしていく。
3. 問題解決機能を実装する。

# 本アプリケーションの注意点
本当に専門的なことで困っている場合には薬剤師や医師に相談してもらうようにする必要がある。

# 開発環境
 Ruby 2.6.5
 Rails 6.0.0
 HTML/CSS
 Javascript
 MySQl2 0.4.4
 VA Code

 # ①ユーザー登録詳細画面
![ユーザー登録画面](https://i.gyazo.com/22f11f1c368696ef342be0fc45f8d0fd.png)
![ログイン画面](https://i.gyazo.com/bf0337f058b2edf1d9c633fa29bd4747.png)
 ユーザー登録を行うことが可能になる。
 ユーザー登録を行っていればログインすることが可能である。

 # ②質問投稿機能
![質問投稿機能](https://i.gyazo.com/eb13fd9c4d7c9922a48eef9de650b377.png)
ログインすることで、質問を投稿することが可能になる。
質問は編集、削除を行うことが可能である。
 # ③質問回答機能
![質問投稿機能](https://i.gyazo.com/96c46026f3c8d0d8478ccecccc459052.png)
ログインすることで、回答をすることが可能になる。
回答は編集・削除することが可能である。
 # ④薬の飲み方情報詳細ページ
![服用方法詳細ページ](https://i.gyazo.com/18ade04b02bf1803c44a687ea095bf1c.png)
薬の飲み方に関しての情報を得ることができる。

# テーブル設計

## Users テーブル

|  Column             |  Type       |  Options                   |
| ------------------- | ----------- | -------------------------- |
|  nickname           | string      | null: false                |
|  email              | string      | null: false ,  unique:true |
|  password           | string      | null: false                |
|  phone_number       | string      | null: false 

### Association
has_many questions
has_many answers

## Questions テーブル

|  Column            |  Type       |  Options                                      |
| ------------------ | ------------| --------------------------------------------- |
| title              | string       | null: false                                  |                
| content            | string       | null: false                                  |
| user               | reference    | null: false, foreign_key: true               |

### Association
belongs_to user
has_many answers



## Answers テーブル

|  Column            |  Type       |  Options                                      |
| ------------------ | ----------- | --------------------------------------------- |
| text               | string      | null: false                                   |
| user               | reference   | null: false,  foreign_key:  true              |
| question           | reference   | null: false,  foreign_key:  true              |

### Association 
belongs_to user
belongs_to question