require 'csv'

namespace :load do
  desc "loads invoice csv file"
  task :invoices do
    csv_text = File.read('db/data/invoices.csv')
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Invoice.create(row.to_hash)
    end
    puts "Invoice file loaded into database."
  end
end
