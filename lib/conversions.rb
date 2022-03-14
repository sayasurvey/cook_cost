require 'csv'

class Conversion

  

  csv_data = CSV.read("/Users/yona/rakuten_recipe_output.csv", headers: true)


  File.open("/Users/yona/conversions.csv", 'a') do |file|
    csv_data.each do |data|
      data[2] = data[2].match(/[^一-龠ぁ-んァ-ヶーｦ-ﾟ]*([一-龠ぁ-んァ-ヶーｦ-ﾟ]*)[^一-龠ぁ-んァ-ヶーｦ-ﾟ]*/)[1]
      file.write(data)
    end
  end
end

conversion = Conversion.new