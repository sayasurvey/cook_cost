module RakutenRecipeScrapes
  require 'open-uri'
  require 'nokogiri'
  require 'csv'
  
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
    str.tr("０-９ａ-ｚＡ-Ｚ．＠−", "0-9a-zA-Z.@-")
  end

  def register_recipe_from_html(doc, html_path)
    cuisine_name = doc.xpath("#{html_path}div[2]").text.strip
    originator = doc.xpath("#{html_path}div[3]/div/div[2]/div[2]/a").text.strip
    how_many = doc.xpath("#{html_path}div[3]/section/h2[@class='contents_title contents_title_mb']").text.strip
    @recipe = Recipe.find_or_initialize_by(recipe_url: params[:url], cuisine_name: cuisine_name, originator: originator, how_many: how_many)
    if @recipe.new_record? && !@recipe.save
        render :about
    end
  end

  def register_ingredients_from_html(doc, html_path, url)
    @recipe_id = Recipe.find_by(recipe_url: params[:url]).id
    doc.xpath("#{html_path}div[3]/section/ul").css('li').map do |node|
      synonym = node.css('.recipe_material__item_name').text.strip
      quantity_unit = full_to_half(node.css('.recipe_material__item_serving').text.strip)
      if Synonym.find_by(name: synonym)
        ingredient = Ingredient.includes(:synonyms).find_by(synonyms: { name: synonym } ).name
      else
        @food_cost = FoodCost.find_or_initialize_by(recipe_id: @recipe_id, quantity_unit: quantity_unit, cost: 0, price_id: 100000, note:synonym)
        @food_cost.save if @food_cost.new_record?
        next
      end

      if !(/[0-9.]+/.match(quantity_unit))
        quantity = 1
        unit = quantity_unit.match(/[^\x01-\x7E]+/).string
      elsif /([大小]+[さじ]*[匙]*)([0-9.\/]*)[~〜]*[0-9.\/]*/.match(quantity_unit)
        quantity_unit = quantity_unit.match(/([大小]+[さじ]*[匙]*)([0-9.\/]*)[~〜]*[0-9.\/]*/)
        unit = quantity_unit[1]
        if /\//.match(quantity_unit[2])
          fraction = quantity_unit[2].match(/([0-9])+\/([0-9])/)
          quantity = (fraction[1].to_f / fraction[2].to_f).round(2)
        else
          quantity = quantity_unit[2].to_f
        end
        quantity_unit = "#{quantity_unit[1]}#{quantity_unit[2]}"
      elsif /([0-9.\/]+)[~～]*[0-9.\/]*([個本コこケ缶片袋杯膳束合枚鞘房a-z|グラム|]*)/.match(quantity_unit)
        quantity_unit = quantity_unit.match(/([0-9.\/]+)[~～]*[0-9.\/]*([個本コこケ缶片袋杯膳束合枚鞘房a-z|グラム|パック|]*)/)
        unit = quantity_unit[2]
        if /\//.match(quantity_unit[1])
          fraction = quantity_unit[1].match(/([0-9])+\/([0-9])/)
          quantity = (fraction[1].to_f / fraction[2].to_f).round(2)
        else
          quantity = quantity_unit[1].to_f
        end
        quantity_unit = "#{quantity_unit[1]}#{quantity_unit[2]}"
      end

      if unit == Ingredient.find_by(name: ingredient).base_unit
        amount = quantity
      else
        ratio = IngredientUnit.includes(:ingredient, :unit).find_by(ingredient: { name: ingredient }, unit: { unit: unit }).ratio.to_f
        amount = ratio * quantity
      end
      cost = amount * Price.includes(:ingredient).find_by(ingredient: { name: ingredient }).one_base_unit_price
      @food_cost = FoodCost.find_or_initialize_by(recipe_id: @recipe_id, quantity_unit: quantity_unit, cost: cost, price_id: Price.includes(:ingredient).find_by(ingredient: { name: ingredient }).id, note: '')
      if @food_cost.new_record? && !@food_cost.save
        render :about
      end
    end
  end
end