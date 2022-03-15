class ApplicationController < ActionController::Base
  include RakutenRecipeScrapes
  add_flash_types :success, :info, :warning, :danger
end
