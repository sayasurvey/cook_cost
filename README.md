# サービス概要
楽天レシピのレシピから材料費と栄養素を計算して表示するサービス。

# アプリを作ったきっかけ
過去に『「5人家族で食費2万円台」に反発が相次いだ理由 「これ以上節約は無理」「食費が削られるのでは」という主婦の嘆き』という記事を読んだ。  
https://news.careerconnection.jp/pickup/98123/  
趣味でYouTubeの5チャンネルのまとめ動画をみるのだが、  
そちらでも無意識に経済DVをしている人を度々見かける。（5人家族で食費4万など）  
楽天レシピに材料費が載っているが、その値段では食材がセールの価格でも上回ってしまうものも度々ある。  
一般的な食材の価格でこれくらいかかるよっていうのがわかれば、無理な要求をはねのけたり、  
月末に食費が足りなくなることが少なくなるのではないかと思った。

# アプリに込めた思い
貧困や経済DVなどが理由で、満足な食事を食べられない人もいる。  
低価格で作れるレシピを探しやすくすることで、レシピのバリエーションも増えるし、食事の満足度も上がる。  
栄養バランスのいい食事をお腹いっぱいに食べれる家庭が増えるといいなと思う。

# 主な機能
## ログインなしでできること
・楽天レシピのURLを入力することでレシピの登録  
・カテゴリー一覧からレシピの選択や登録  
・すでに登録されたレシピから選択  
・ユーザーが登録または選択したレシピの材料費と栄養素の閲覧  
・レシピ名等の検索機能  
・お問い合わせ機能  
・Twitterシェア機能  
|URLから探す|カテゴリーから探す|登録済みのレシピから探す|
|---|---|---|
|![URLから探す](https://user-images.githubusercontent.com/89208789/163760370-259bb5b0-e0e1-4770-a6fd-fd366c54d61c.gif)|![カテゴリーから探す](https://user-images.githubusercontent.com/89208789/163760393-72426f81-0431-4973-89f2-6f6d98007d02.gif)|![登録済みのレシピから探す](https://user-images.githubusercontent.com/89208789/163760400-d4042f7e-89ad-4b52-b997-eb0db94312b7.gif)|  

## ログイン後できること
・ブックマーク機能
|ログイン機能|SNSログイン機能|ブックマーク機能|
|---|---|---|
|![ログイン](https://user-images.githubusercontent.com/89208789/163764019-ee3fb53b-9470-40a4-9a49-66dd7a912ef6.gif)|![SNS認証](https://user-images.githubusercontent.com/89208789/163764016-523f0c42-0ed0-4a9b-9c15-8ed799a45a03.gif)|![ブックマーク機能](https://user-images.githubusercontent.com/89208789/163764022-c985506d-8bed-417d-9d03-e8907424f317.gif)|  
# 使用技術
## バックエンド
・Ruby 3.1.0  
・Ruby on Rails 6.1.4

## 主要Gem
・sorcery  
・nokogiri  
・capybara  
・seed-fu  
・ransack  
・meta-tags  

## フロントエンド
・JavaScript  
・Bootstrap

## インフラ
・Heroku  
・PostgreSQL

## その他
・楽天レシピカテゴリ別ランキングAPI  
・chart.js

# 画面遷移図
[Figma](https://www.figma.com/file/DEMJHv3GKw0BrKaWAQhvK5/%E3%82%B9%E3%83%9E%E3%83%9B?node-id=2%3A10)

# ER図
[![Image from Gyazo](https://i.gyazo.com/5e322c7796c457e865f41fc8d1d886d0.png)](https://gyazo.com/5e322c7796c457e865f41fc8d1d886d0)