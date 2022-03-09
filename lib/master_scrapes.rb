require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'csv'

class Scrape
  #DSLのスコープを別けないと警告がでます
  include Capybara::DSL

  def initialize()
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {
                        js_errors: false,
                        timeout: 1000,
                        phantomjs_options: [
                                  '--load-images=no',
                                  '--ignore-ssl-errors=yes',
                                  '--ssl-protocol=any']})
    end

    Capybara.default_driver = :poltergeist
    Capybara.javascript_driver = :poltergeist
  end

  def visit_site
    page.driver.headers # => {}
    #ユーザエージェントの設定（必要に応じて）
    page.driver.headers = { "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36" }
    #リファラーの偽装（特に不要）
    #page.driver.add_headers("Referer" => "http://yahoo.co.jp")
    page.driver.headers
    header = ['キーワード', 'URL', '材料名', '分量']
    rows = []
    rows << header
    ARGV.each_with_index do |arg, i|
      visit('https://recipe.rakuten.co.jp/')
      fill_in 'header_search_input', with: arg
      find('div.field_search button').click
      sleep 5
      target_url_array = page.all('.recipe_ranking__item a').map {|item| item[:href] }
      target_url_array.each do |target_url|
        visit target_url
        doc = Nokogiri::HTML.parse(html, nil)
        html_path = "/html/body/div/div[2]/div/div[3]/section/ul"
        doc.xpath(html_path).css('li').map do |node|
          synonym = node.css('.recipe_material__item_name').text.strip
          quantity_unit = node.css('.recipe_material__item_serving').text.strip
          CSV.open('/Users/yona/rakuten_recipe_output.csv', 'a') do |file|
            file << [arg, target_url, synonym, quantity_unit]
          end
        end
      end
    end
  end
end

scrape = Scrape.new
scrape.visit_site