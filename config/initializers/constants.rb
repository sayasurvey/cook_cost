module Constants
  JAPANESE_ONLY = /[^一-龠ぁ-んァ-ヶーｦ-ﾟ]*([一-龠ぁ-んァ-ヶ・ーｦ-]*)[^一-龠ぁ-んァ-ヶーｦ-ﾟ]*/
  UNIT_SPOON = /([大小]+[さじ]*[匙]*)([0-9.\/]+)[~〜]*[0-9.\/]*/
  UNIT_CAP = /([カップ]+)([0-9.\/]+)[~〜]*[0-9.\/]*/
  UNIT_AFTER = /([0-9.\/]+)[~～]*[0-9.\/]*([個本コこヶ缶片袋杯膳束合枚鞘房握玉つ人食切匹尾株枚斤半玉ケ丁粒箱周滴柵a-zA-Zℊｇ㌘㏄|グラム|つかみ|つまみ｜ｸﾞﾗﾑ|カップ|パック|かけ|センチ|カケ|リットル|回し|まい|節|カット|㎝|ｶｹ|]*)/
  UNIT_AFTER_PARENTHESES = /([0-9.\/]+)[~～]+[0-9.\/]+([個本コこヶ缶片袋杯膳束合枚鞘房握玉つ人食切匹尾株枚斤半玉ケ丁粒箱周滴柵a-zA-Zℊｇ㌘㏄|グラム|つかみ|つまみ｜ｸﾞﾗﾑ|カップ|パック|かけ|センチ|カケ|リットル|回し|まい|節|カット|㎝|ｶｹ|]*)/
  NO_REGISTRATION = 100000
  SHOW_RECIPES_SELECT_COLUMNS = 'ingredients.name, prices.purchase_price, prices.quantity, prices.unit_id, food_costs.id, food_costs.quantity_unit, food_costs.cost, food_costs.note'
end