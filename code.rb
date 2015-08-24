#YOUR CODE GOES HERE
require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

db_connection do |conn|
  a = conn.exec("SELECT * FROM ingredients")
  a.each do |item|
    puts "#{item['id']}. #{item['ingredient']}"
  end
end
