begin
  require 'hirb'
  # これが無いとdisplay_widthが無くてエラー
  require 'unicode/display_width/string_ext'
  # これもrequireしないと勝手には反応しない
  require 'hirb-unicode'
rescue LoadError
  # hirbがrequireできないでござる
end

if defined? Rails::Console

  if defined? Hirb
    Hirb.enable
  end

end
