namespace :load do
  desc "resets database and loads all csv files"
  task :csv do
    Rake::Task['db:migrate:reset'].invoke
    Rake::Task['load:customers'].invoke
    Rake::Task['load:merchants'].invoke
    Rake::Task['load:items'].invoke
    Rake::Task['load:invoices'].invoke
    Rake::Task['load:invoice_items'].invoke
    Rake::Task['load:transactions'].invoke
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    puts "All CSV files loaded into database!"
  end
end
