require 'csv'

namespace :load do
  desc "loads merchant csv file"
  task :merchants do
    csv_text = File.read('db/data/merchants.csv')
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Merchant.create(row.to_hash)
    end
    puts "Merchant file loaded into database."
  end
end
