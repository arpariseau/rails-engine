require 'csv'

namespace :load do
  desc "loads customer csv file"
  task :customers do
    csv_text = File.read('db/data/customers.csv')
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      Customer.create(row.to_hash)
    end
    puts "Customer file loaded into database."
  end
end
