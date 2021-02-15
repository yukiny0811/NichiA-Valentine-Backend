require "bundler/setup"
Bundler.require

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || "sqlite3:db/development.db")

class User < ActiveRecord::Base 
  
end

class Chocolate < ActiveRecord::Base 
  
end

class Haikei < ActiveRecord::Base 
  
end