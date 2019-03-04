require "sqlite3"
require "csv"
require "pry"


 csv_array = []

 File.open('daily_show_guests.csv').each do |line|
  csv_array << line.split(',')
end

 db = SQLite3::Database.new "guests.db"

 sql = <<-SQL
  DROP TABLE IF EXISTS guests
SQL

 db.execute(sql)

 sql = <<-SQL
    CREATE TABLE IF NOT EXISTS guests (
    id INTEGER PRIMARY KEY,
    year INTEGER,
    job TEXT,
    show TEXT,
    group_name TEXT,
    name TEXT
  );
SQL

 db.execute(sql)

 csv_array.shift

 #binding.pry
csv_array.each do |line|
  sql = <<-SQL
    INSERT INTO guests (year, job, show, group_name, name) VALUES
    (?, ?, ?, ?, ?)
  SQL
  db.execute(sql, line[0], line[1], line[2], line[3], line[4])
end
