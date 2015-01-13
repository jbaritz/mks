require 'active_record_tasks'

ActiveRecordTasks.configure do |config|
  # These are all the default values
  config.db_dir = 'db'
  config.db_config_path = 'db/config.yml'
  config.env = 'development'
end

# Run this AFTER you've configured
ActiveRecordTasks.load_tasks

task :environment do
  require './lib/petshop.rb'
end

task :console => :environment do
  require 'irb'
  ARGV.clear
  IRB.start
end


namespace :db do

  task :create do
    `createdb petshop_db`
  
    puts "Created."
  end

  task :drop do
    `dropdb petshop_db`
    puts "Dropped."
  end

  task :create_tables => :environment do
    db1 = PetShop.create_db_connection('petshop_db')
    PetShop.create_tables(db1)
  
    puts "Created tables."
  end

  task :drop_tables => :environment do
    db1 = PetShop.create_db_connection('petshop_db')
 
    PetShop.drop_tables(db1)
 
    puts "Dropped tables."
  end

  task :clear => :environment do
    # The test db clears all the time, so there's no point in doing it here.
    db = PetShop.create_db_connection('petshop_db')

    PetShop.drop_tables(db)
 
    PetShop.create_tables(db)

    puts "Cleared tables."
  end

  task :seed => :environment do
    db = PetShop.create_db_connection('petshop_dev')
    PetShop.seed_db(db)
    puts "Seeded."
  end

end
