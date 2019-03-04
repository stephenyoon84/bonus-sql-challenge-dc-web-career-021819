require 'bundler'
require_relative '../lib/queries.rb'
require_relative '../db/seed.rb'
require 'pry'

Bundler.require

# Setup a DB connection here

# DB = {:conn => SQLite3::Database.new("db/guests.db")}
db = SQLite3::Database.new "guests.db"
