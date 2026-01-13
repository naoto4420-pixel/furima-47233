# README

## usersテーブル

| Column              | Type        | Options                    |
| ------------------- | ----------- | -------------------------- |
| nickname            | string      | null: false                |
| email               | string      | null: false, unique: true  |
| encrypted_password  | string      | null: false                |
| family_name         | string      | null: false                |
| first_name          | string      | null: false                |
| family_name_kana    | string      | null: false                |
| first_name_kana     | string      | null: false                |
| birthday            | date        | null: false                |

### Association
- has_many   :items
- has_many   :orders


## itemsテーブル

| Column                   | Type        | Options                         |
| ------------------------ | ----------- | ------------------------------- |
| name                     | string      | null: false                     |
| explain                  | text        | null: false                     |
| price                    | integer     | null: false                     |
| category                 | integer     | null: false                     |
| condition                | integer     | null: false                     |
| shipping_costs           | integer     | null: false                     |
| shipping_origin_region   | integer     | null: false                     |
| estimated_shipping _date | integer     | null: false                     |
| user_id                  | references  | null: false, foreign_key: true  |

### Association
- belongs_to  :user
- has_one     :order


## ordersテーブル

| Column           | Type        | Options                         |
| ---------------- | ----------- | ------------------------------- |
| item             | references  | null: false, foreign_key: true  |
| user             | references  | null: false, foreign_key: true  |
| shipping_address | references  | null: false, foreign_key: true  |

### Association
- belongs_to  :user
- belongs_to  :item
- has_one     :shipping_address


## shipping_addressesテーブル

| Column         | Type        | Options                         |
| -------------- | ----------- | ------------------------------- |
| post_code      | integer     | null: false                     |
| prefecture     | integer     | null: false                     |
| municipality   | string      | null: false                     |
| street_address | string      | null: false                     |
| building_name  | string      |                                 |
| phone_number   | integer     | null: false                     |

### Association
- belongs_to  :order
