require "sqlite3"


db = SQLite3::Database.new "guests.db"

def most_common_guest(db)
 sql = <<-SQL
   SELECT name, COUNT(name)
   FROM guests
   GROUP BY name
   ORDER BY COUNT(name)
   DESC
   LIMIT 1
 SQL

  out = db.execute(sql).flatten
 puts "The most common guest was #{out[0]} with #{out[1]} appearances."
 puts "\n"
end

def most_common_job_by_year(db)
 sql = <<-SQL
   SELECT year
   FROM guests
   GROUP BY year
 SQL

  years = db.execute(sql).flatten

  sql = <<-SQL
   SELECT year, job, COUNT(job)
   FROM guests
   WHERE year = ?
   GROUP BY job
   ORDER BY COUNT(job)
   DESC
   LIMIT 1
 SQL

  out = []

  years.each do |year|
   out << db.execute(sql, year).flatten
   puts "In #{year} the most common profession were #{out.last[1]}s. There were #{out.last[2]} of them."
 end
 puts "\n"
 out

end

def most_common_job_overall(db)
 sql = <<-SQL
   SELECT job, COUNT(job)
   FROM guests
   GROUP BY job
   ORDER BY COUNT(job)
   DESC
   LIMIT 1
 SQL

  out = db.execute(sql).flatten
 puts "The most common job overall were #{out[0]}s with #{out[1]} guests."
 puts "\n"
 out
end

def number_of_bills(db)
 sql = <<-SQL
   SELECT COUNT(name)
   FROM guests
   WHERE name LIKE 'Bill %'
 SQL

  out = db.execute(sql).flatten
 puts "There were #{out[0]} Bills on the show in total."
 puts "\n"
 out
end

def pat_stew_dates(db)
 sql = <<-SQL
   SELECT show
   FROM guests
   WHERE name = 'Patrick Stewart\n'
 SQL

  out = db.execute(sql).flatten
 puts "Patrick Stewart appeared on the daily show on the following dates:"
 out.each do |date|
   puts date
 end
 puts "\n"
 out
end

def year_with_most_guests(db)
 sql = <<-SQL
   SELECT year, COUNT(id)
   FROM guests
   GROUP BY year
   ORDER BY COUNT(id)
   DESC
   LIMIT 1
 SQL

  out = db.execute(sql).flatten
 puts "The year with the most guests was #{out[0]} with #{out[1]} guests in total."
 puts "\n"
 out
end

def most_common_group_by_year(db)
 sql = <<-SQL
   SELECT year
   FROM guests
   GROUP BY year
 SQL

  years = db.execute(sql).flatten

  sql = <<-SQL
   SELECT year, group_name, COUNT(group_name)
   FROM guests
   WHERE year = ?
   GROUP BY job
   ORDER BY COUNT(job)
   DESC
   LIMIT 1
 SQL

  out = []

  years.each do |year|
   out << db.execute(sql, year).flatten
   puts "In #{year} the most popular group was #{out.last[1]}s. They appeared #{out.last[2]} times that year."
 end
 puts "\n"
 out
end

most_common_guest(db)
most_common_job_by_year(db)
most_common_job_overall(db)
number_of_bills(db)
pat_stew_dates(db)
year_with_most_guests(db)
most_common_group_by_year(db)
