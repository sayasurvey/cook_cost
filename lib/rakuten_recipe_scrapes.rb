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
    register_ingredients_from_html(doc, html_path)
  end

  def full_to_half(str)
    str.tr("０-９ａ-ｚＡ-Ｚ．＠−", "0-9a-zA-Z.@-")
  end

  def register_recipe_from_html(doc, html_path)
    cuisine_name = doc.xpath("#{html_path}div[2]").text.strip
    originator = doc.xpath("#{html_path}div[3]/div/div[2]/div[2]/a").text.strip
    binding.irb
    how_many = doc.xpath("#{html_path}div[3]/section/h2[@class='contents_title contents_title_mb']").text.strip
    @recipe = Recipe.find_or_initialize_by(recipe_url: params[:url], cuisine_name: cuisine_name, originator: originator, how_many: how_many)
    if @recipe.new_record? && !@recipe.save
        render :about
    end
  end

  def register_ingredients_from_html(doc, html_path)
    doc.xpath("#{html_path}div[3]/section/ul").css('li').map do |node|
      synonym = node.css('.recipe_material__item_name').text.strip
      ingredient = Ingredient.includes(:synonyms).find_by(synonyms: { name: synonym } ).name
      quantity_unit = full_to_half(node.css('.recipe_material__item_serving').text.strip)
      quantity = quantity_unit.gsub(/[^[0-9.]]/, "").to_f
      unit = quantity_unit.delete("0-9.")
      if unit == Ingredient.find_by(name: ingredient).base_unit
        amount = quantity
      else
        ratio = IngredientUnit.includes(:ingredient, :unit).find_by(ingredient: { name: ingredient }, unit: { unit: unit }).ratio.to_i
        amount = ratio * quantity
      end
      cost = amount * Price.includes(:ingredient).find_by(ingredient: { name: ingredient }).one_base_unit_price
      @recipe_id = Recipe.find_by(recipe_url: params[:url]).id
      @food_cost = FoodCost.find_or_initialize_by(recipe_id: @recipe_id, quantity_unit: quantity_unit, cost: cost, price_id: Price.includes(:ingredient).find_by(ingredient: { name: ingredient }).id)
      if @food_cost.new_record? && !@food_cost.save
        render :about
      end
    end
  end
end