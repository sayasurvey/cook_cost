require 'csv'

data_dir = "#{Rails.root}/db/fixtures/master_data"
full_pattern = File.join(data_dir, '*.csv')

Dir.glob(full_pattern).each do |path|
  filename = File.basename(path, '.csv')
  klass = filename.capitalize.singularize
  model = Rails.const_get(klass)

  csv = CSV.read(path, headers: true)
  csv.each do |row|
    model.seed(:id) do |m|
      csv.headers.each { |h| eval("m.#{h} = #{row[h].inspect}") }
    end
  end
end