require 'csv'

namespace :load do
  desc "loads transaction csv file"
  task :transactions do
    csv_text = File.read('db/data/transactions.csv')
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Transaction.create(row.to_hash)
    end
    puts "Transaction file loaded into database."
  end
end
