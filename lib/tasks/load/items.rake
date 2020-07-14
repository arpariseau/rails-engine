require 'csv'

namespace :load do
  desc "loads item csv file"
  task :items do
    csv_text = File.read('db/data/items.csv')
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      item_row = row.to_hash
      item_row["unit_price"] = item_row["unit_price"].to_f / 100
      Item.create(item_row)
    end
    puts "Item file loaded into database."
  end
end
