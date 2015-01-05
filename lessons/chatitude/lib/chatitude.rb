require 'pg'
require 'securerandom'

module Chat
  class DB
    def self.create_tables
      db.exec <<-SQL
        CREATE TABLE IF NOT EXISTS users(
          id       SERIAL PRIMARY KEY,
          username VARCHAR,
          password VARCHAR
          ); 
        CREATE TABLE IF NOT EXISTS api_keys(
        id        SERIAL PRIMARY KEY,
        user_id   INTEGER REFERENCES users(id),
        api_key   VARCHAR
        ); 
      CREATE TABLE IF NOT EXISTS chats(
        id SERIAL PRIMARY KEY,
        user_id   INTEGER REFERENCES users(id),
        message   TEXT,
        time TIMESTAMP
        );
      SQL
    end

    def self.connect_db
      PG.connect(host: 'localhost', dbname: 'chatitude')
    end

    def self.new_user(name, pword, db)
      sql = <<-SQL
        INSERT INTO users (username, password)
        values ($1, $2) returning *
        SQL
      result = db.exec(sql, [name, pword]).to_a.first
      new_key = self.generate_apikey
      db.exec("INSERT INTO api_keys (user_id, api_key) VALUES ($1,$2)", [result['id'],new_key])
      result    
    end

    def self.find_user_byname(username, db)
      db.exec("SELECT * FROM users where username = $1", [username]).to_a.first
    end
    
    def self.find_api_key(user_id, db)
      db.exec("SELECT api_key FROM api_keys WHERE user_id = $1", [user_id]).entries.first
    end

     def self.check_api(key, db)
      db.exec("SELECT user_id FROM api_keys WHERE api_key = $1", [key]).entries.first
    end

    def self.newchat(user_id, message, db)
      db.exec("INSERT INTO chats (user_id, message, time) VALUES ($1,$2,$3)", [user_id, message,DateTime.now])
    end

    def self.getchats(db)
      db.exec("Select message, username, time from chats c join users u on c.user_id = u.id").to_a
    end

    def self.generate_apikey
      SecureRandom.hex
    end

  end
end