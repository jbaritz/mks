require 'pg'

class Classmates
  def initialize
  @db = PG.connect(host: 'localhost', dbname:'classmates_db')
  create_tables
  end

 def create_tables
    sql = %q[
      CREATE TABLE IF NOT EXISTS classmates(
      first_name VARCHAR,
      last_name VARCHAR, 
      twitter_handle VARCHAR,
      age int
      )
    ]

    @db.exec(sql)
  end
  #first_name VARCHAR, last_name VARCHAR, age numeric, twitter_handle VARCHAR

  def make_new_classmate
    puts "What is the first name of the new classmate?"
    first = gets.chomp
    puts "What is the last name?"
    last = gets.chomp
    puts "What is the classmate's age?"
    age = gets.chomp.to_i
    puts "What is their twitter handle?"
    twitter = gets.chomp
    sql = %q[
         INSERT INTO classmates (first_name, last_name, twitter_handle, age)
         VALUES ($1, $2, $3, $4)
        ]
    @db.exec_params(sql, [first, last, twitter, age]) #the $1, $2, etc. map onto the order of first, last, twitter, age here

    # @db.exec("INSERT INTO classmates (first_name, last_name, age, twitter_handle) VALUES ('#{first}', '#{last}', '#{age}', '#{twitter}');")
    success = @db.exec("SELECT * FROM classmates WHERE first_name = '#{first}' AND last_name = '#{last}';")
    puts "You successfully added: #{success.entries}"
  end

  def view_all
    result = @db.exec("SELECT * FROM classmates;")
    puts result.entries
  end

  def delete(db, firstname, lastname)
    @db.exec("DELETE FROM classmates WHERE first_name = '#{firstname}' AND last_name = '#{lastname}';")

    # sql = %q[
    #   DELETE FROM classmates WHER id = $1
    # ]
    # result = @db.exec_params(sql, [id])
    # result.entries
  end

  def update(db, firstname, lastname)
    puts "What is the first name of the updated classmate?"
    first = gets.chomp
    puts "What is the last name?"
    last = gets.chomp
    puts "What is the classmate's age?"
    age = gets.chomp.to_i
    puts "What is their twitter handle?"
    twitter = gets.chomp
    @db.exec("UPDATE classmates SET first_name = '#{first}', last_name = '#{last}', age = '#{age}', twitter_handle = '#{twitter}' WHERE first_name = '#{firstname}' AND last_name = '#{lastname}';")
    success = @db.exec("SELECT * FROM classmates WHERE first_name = '#{first}' AND last_name = '#{last}';")
    puts "Your updated entry is: #{success.entries}"
  end

  def update_a_record(id, opts={})
      columns=opts.keys
      values = opts.values
      sql = %q[
        UPDATE classmates SET($1) = ($2)
      ]
      result = @db.exec_params(sql, [columns, values])
  end
end

class CLIENT
  def self.command_list
    puts "Command List"
    puts "1. add a record"
    puts "2. view all records"
    puts "3. delete a record"
    puts "4. update a record"
  end

  def self.start
    @cm = Classmates.new
    command_list
    print "SELECT ONE:"
    input = gets.chomp
    case input
    when 0
      add_record(input)
    when 2
      view_all
    when 3
      delete(input)
    when 4
      update_a_record(input)
    end
  end

  def self.add_record(input)
    pieces = input.split
    first = input[1]
    last = input[2]
    @cm.make_new_classmate
  end
end
