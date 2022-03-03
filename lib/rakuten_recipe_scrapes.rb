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

    header = ['材料名', '分量']
    rows = []
    rows << header
    doc = Nokogiri::HTML.parse(html, nil, charset)
    cuisine_name = doc.xpath("/html/body/div/div[2]/div/div[2]").text.strip
    originator = doc.xpath("/html/body/div/div[2]/div/div[3]/div/div[2]/div[2]/a").text.strip
    doc.xpath("/html/body/div/div[2]/div/div[3]/section/ul").css('li').map do |node|
      ingredient = node.css('.recipe_material__item_name').text.strip
      amount = node.css('.recipe_material__item_serving').text.strip
      rows << [ingredient, amount]
    end

    return [url, cuisine_name, originator, rows]
  end
end