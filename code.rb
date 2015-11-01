#YOUR CODE GOES HERE
require 'pg'
require 'pry'
require 'csv'

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
# only add stuff once: (doesn't work right now...)
if ingredients.empty?
  CSV.foreach('ingredients.csv') do |row|
    db_connection do |list_item|
      list_item.exec_params("INSERT INTO ingredients ('id') VALUES ($1)", [row['ingredient']])
    end
    ensure
      connection.close
    end
  end
end
