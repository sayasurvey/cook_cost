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

csv = CSV.read("#{data_dir}ChildCategories.csv", headers: true)

csv.each do |child_categories|
  ChildCategory.seed(:id) do |s|
    s.id  = child_categories[0]
    s.category = Category.find_by(name: child_categories[1])
    s.name = child_categories[2]
    s.rakuten_id = child_categories[3]
  end
end

csv = CSV.read("#{data_dir}IngredientLists.csv", headers: true)

csv.each do |ingredient_list|
  IngredientList.seed(:id) do |s|
    s.id  = ingredient_list[0]
    s.ingredient = Ingredient.find_by(name: ingredient_list[1])
    s.unit = Unit.find_by(unit: ingredient_list[2])
    s.calorie = ingredient_list[3]
    s.carbohydrate = ingredient_list[4]
    s.protein = ingredient_list[5]
    s.lipid = ingredient_list[6]
    s.dietary_fiber = ingredient_list[7]
    s.salt_equivalent = ingredient_list[8]
  end
end
