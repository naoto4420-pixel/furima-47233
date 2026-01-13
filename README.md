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

| Column                      | Type        | Options                         |
| --------------------------- | ----------- | ------------------------------- |
| name                        | string      | null: false                     |
| explain                     | text        | null: false                     |
| price                       | integer     | null: false                     |
| category_id                 | integer     | null: false                     |
| condition_id                | integer     | null: false                     |
| shipping_cost_id            | integer     | null: false                     |
| prefecture_id               | integer     | null: false                     |
| estimated_shipping _date_id | integer     | null: false                     |
| user                        | references  | null: false, foreign_key: true  |

### Association
- belongs_to  :user
- has_one     :order


## ordersテーブル

| Column           | Type        | Options                         |
| ---------------- | ----------- | ------------------------------- |
| item             | references  | null: false, foreign_key: true  |
| user             | references  | null: false, foreign_key: true  |

### Association
- belongs_to  :user
- belongs_to  :item
- has_one     :shipping_address


## shipping_addressesテーブル

| Column         | Type        | Options                         |
| -------------- | ----------- | ------------------------------- |
| post_code      | string      | null: false                     |
| prefecture_id  | integer     | null: false                     |
| municipality   | string      | null: false                     |
| street_address | string      | null: false                     |
| building_name  | string      |                                 |
| phone_number   | string      | null: false                     |
| order          | references  | null: false, foreign_key: true  |

### Association
- belongs_to  :order
