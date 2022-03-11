require 'csv'

data_dir = "db/fixtures/association_data/"
csv = CSV.read("#{data_dir}IngredientUnits.csv", headers: true)

csv.each do |ingredient_unit|
  IngredientUnit.seed(:id) do |s|
    s.id  = ingredient_unit[0]
    s.ingredient = Ingredient.find_by(name: ingredient_unit[1])
    s.unit = Unit.find_by(unit: ingredient_unit[2])
    s.ratio = ingredient_unit[3]
  end
end

csv = CSV.read("#{data_dir}Prices.csv", headers: true)

csv.each do |price|
  Price.seed(:id) do |s|
    s.id  = price[0]
    s.ingredient = Ingredient.find_by(name: price[1])
    s.purchase_price = price[2]
    s.quantity = price[3].to_f
    s.unit = Unit.find_by(unit: price[4])
    s.one_base_unit_price = (price[2].to_i / (price[3].to_f * IngredientUnit.includes(:ingredient, :unit).find_by(ingredient: { name: price[1] }, unit: { unit: price[4] }).ratio)).round(4)
  end
end

csv = CSV.read("#{data_dir}Synonyms.csv", headers: true)

csv.each do |synonym|
  Synonym.seed(:id) do |s|
    s.id  = synonym[0]
    s.ingredient = Ingredient.find_by(name: synonym[1])
    s.name = synonym[2]
  end
end