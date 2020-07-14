require 'csv'

namespace :load do
  desc "loads invoice item csv file"
  task :invoice_items do
    csv_text = File.read('db/data/invoice_items.csv')
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      inv_item_row = row.to_hash
      inv_item_row["unit_price"] = inv_item_row["unit_price"].to_f / 100
      InvoiceItem.create(inv_item_row)
    end
    puts "Invoice item file loaded into database."
  end
end
