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
    cuisine_name = doc.xpath("#{html_path}div[2]").text.strip
    originator = doc.xpath("#{html_path}div[3]/div/div[2]/div[2]/a").text.strip
    doc.xpath("#{html_path}div[3]/section/ul").css('li').map do |node|
      synonym = node.css('.recipe_material__item_name').text.strip
      ingredient = Ingredient.joins(ingredient_synonyms: :synonym).find_by(synonym: {name: synonym}).name
      qutntitiy_unit = full_to_half(node.css('.recipe_material__item_serving').text.strip)
      quantity = qutntitiy_unit.gsub(/[^[0-9.]]/, "").to_f
      unit = qutntitiy_unit.delete("0-9.")
      if Unit.find_by(unit: unit).id == Ingredient.find_by(name: ingredient).base_unit
        amount = quantity
      else
        ratio = IngredientUnit.joins(:ingredient, :unit).find_by(ingredient: { name: ingredient }, unit: { unit: unit }).ratio.to_i
        amount = ratio * quantity
      end
      cost = amount * Price.joins(:ingredient).find_by(ingredient: { name: ingredient }).one_base_unit_price
      rows << [ingredient, qutntitiy_unit, cost]
    end

    return [url, cuisine_name, originator, rows]
  end

  def full_to_half(str)
    str.tr("０-９ａ-ｚＡ-Ｚ．＠−", "0-9a-zA-Z.@-")
  end
end