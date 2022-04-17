RSpec.configure do |config|
  config.before(:each, type: :system)do
    driven_by(:selenium_chrome) #ドライバを一元指定
  end
end