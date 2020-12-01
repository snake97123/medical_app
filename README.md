# テーブル設計

## Users テーブル

|  Column             |  Type       |  Options                   |
| ------------------- | ----------- | -------------------------- |
|  nickname           | string      | null: false                |
|  email              | string      | null: false ,  unique:true |
|  password           | string      | null: false                |
|  phone_number       | string      | null: false 
### Association




## Questions テーブル

|  Column            |  Type        |  Options                                     |
| ------------------ | ------------ | -------------------------------------------- |
| title              | string       | null: false                                  |
| content            | string       | null: false                                  |
| user               | reference    | null: false, foreign_key: true               |

### Association




## Answers テーブル

|  Column            |  Type       |  Options                                      |
| ------------------ | ----------- | --------------------------------------------- |
| text               | string      | null: false                                   |
| user               | reference   | null: false,  foreign_key:  true              |
| question           | reference   | null: false,  foreign_key:  true              |

### Association 
