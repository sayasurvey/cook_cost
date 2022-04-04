module RakutenRecipeScrapes
  require 'open-uri'
  require 'nokogiri'
  
  def scrape_rakuten_recipes(url)
    charset = nil
    html = URI.open(url) do |f|
      charset = f.charset
      f.read
    end

    header = ['材料名', '分量', '材料費']
    rows = []
    rows << header
    doc = Nokogiri::HTML.parse(html, nil, charset)
    html_path = "/html/body/div/div[2]/div/"
    register_recipe_from_html(doc, html_path)
    register_ingredients_from_html(doc, html_path, url)
  end

  def full_to_half(str)
    str.tr("０-９ａ-ｚＡ-Ｚ．（）／〜＠−", "0-9a-zA-Z.()/~@-")
  end

  def register_recipe_from_html(doc, html_path)
    cuisine_name = doc.xpath("#{html_path}div[2]").text.strip.match(/(.*) レシピ・作り方/)[1]
    originator = doc.xpath("#{html_path}div[3]/div/div[2]/div[2]/a").text.strip
    how_many = doc.xpath("#{html_path}div[3]/section/h2[@class='contents_title contents_title_mb']").text.strip
    @recipe = Recipe.find_or_initialize_by(recipe_url: params[:url])
    @recipe.assign_attributes(recipe_url: params[:url], cuisine_name: cuisine_name, originator: originator, how_many: how_many)
    @recipe.save
  end

  def register_ingredients_from_html(doc, html_path, url)
    recipe_id = Recipe.find_by(recipe_url: params[:url]).id
    #そのレシピを過去に作成したときにFoodCostにprice_idで未登録(100000)があれば、その情報を全て削除
    FoodCost.where(recipe_id: recipe_id, price_id: Constants::NO_REGISTRATION).destroy_all
    doc.xpath("#{html_path}div[3]/section/ul").css('li').map do |node|
      synonyms = node.css('.recipe_material__item_name').text.strip.match(Constants::JAPANESE_ONLY)[1].split("・")
      synonyms.each do |synonym|
        if synonym == ""
          synonym = node.css('.recipe_material__item_name').text.strip
        end

        quantity_unit = full_to_half(node.css('.recipe_material__item_serving').text.strip)

        if Synonym.find_by(name: synonym)
          ingredient = Ingredient.includes(:synonyms).find_by(synonyms: { name: synonym } ).name
        else
          #Synonymにsynonymが登録なければFoodCostにprice_idで未登録(100000)で登録
          @food_cost = FoodCost.create(recipe_id: recipe_id, quantity_unit: quantity_unit, cost: 0, price_id: Constants::NO_REGISTRATION, note:synonym)
          next
        end

        quantity_unit, quantity, unit = regular_expression(node, quantity_unit, recipe_id, synonym)
        next if unit == nil

        if unit == Ingredient.find_by(name: ingredient).base_unit
          amount = quantity
        else
          if IngredientUnit.includes(:ingredient, :unit).find_by(ingredient: { name: ingredient }, unit: { unit: unit })
            ratio = IngredientUnit.includes(:ingredient, :unit).find_by(ingredient: { name: ingredient }, unit: { unit: unit }).ratio.to_f
            amount = ratio * quantity
          else
            @food_cost = FoodCost.create(recipe_id: recipe_id, quantity_unit: quantity_unit, cost: 0, price_id: Constants::NO_REGISTRATION, note:synonym)
            next
          end
        end

        cost = amount * Price.includes(:ingredient).find_by(ingredient: { name: ingredient }).one_base_unit_price
        @food_cost = FoodCost.find_or_initialize_by(recipe_id: recipe_id, quantity_unit: quantity_unit, price_id: Price.includes(:ingredient).find_by(ingredient: { name: ingredient }).id)
        #失敗したらエラーにする
        @food_cost.assign_attributes(cost: cost, note: '')
        @food_cost.save
      end
    end
  end

  def regular_expression(node, quantity_unit, recipe_id, synonym)
    if !(/[0-9.]+/.match(quantity_unit))
      quantity = 1
      unit = quantity_unit.match(Constants::JAPANESE_ONLY).string

    elsif Constants::UNIT_SPOON.match(quantity_unit)
      quantity_unit = quantity_unit.match(Constants::UNIT_SPOON)
      unit = quantity_unit[1]
      if /\//.match(quantity_unit[2])
        fraction = quantity_unit[2].match(/([0-9])+\/([0-9])/)
        quantity = (fraction[1].to_f / fraction[2].to_f).round(2)
      else
        quantity = quantity_unit[2].to_f
      end
      quantity_unit = "#{quantity_unit[1]}#{quantity_unit[2]}"

    elsif Constants::UNIT_CAP.match(quantity_unit)
      quantity_unit = quantity_unit.match(Constants::UNIT_CAP)
      unit = quantity_unit[1]
      if /\//.match(quantity_unit[2])
        fraction = quantity_unit[2].match(/([0-9])+\/([0-9])/)
        quantity = (fraction[1].to_f / fraction[2].to_f).round(2)
      else
        quantity = quantity_unit[2].to_f
      end
      quantity_unit = "#{quantity_unit[1]}#{quantity_unit[2]}"

    elsif Constants::UNIT_AFTER.match(quantity_unit)
      if quantity_unit.match(Constants::UNIT_AFTER)[2] == ""
        quantity_unit = quantity_unit.match(Constants::UNIT_AFTER_PARENTHESES)
      else
        quantity_unit = quantity_unit.match(Constants::UNIT_AFTER)
      end

      if quantity_unit == nil
        quantity_unit = full_to_half(node.css('.recipe_material__item_serving').text.strip)
        @food_cost = FoodCost.create(recipe_id: recipe_id, quantity_unit: quantity_unit, cost: 0, price_id: Constants::NO_REGISTRATION, note:synonym)
        return [quantity_unit, quantity, unit]
      end

      unit = quantity_unit[2]

      if /\//.match(quantity_unit[1])
        fraction = quantity_unit[1].match(/([0-9])+\/([0-9])/)
        quantity = (fraction[1].to_f / fraction[2].to_f).round(2)
      else
        quantity = quantity_unit[1].to_f
      end

      quantity_unit = "#{quantity_unit[1]}#{quantity_unit[2]}"
    end

    return [quantity_unit, quantity, unit]
  end
end