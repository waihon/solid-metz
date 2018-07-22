# http://blog.teamtreehouse.com/active-record-without-rails-app

# Instead of loading all of Rails, load the
# particular Rails dependenceies we need.
require 'sqlite3'
require 'active_record'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table :patents, force: true do |t|
    t.string :person_id
    t.string :name
    t.string :title
  end
end

# Set up model classes
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Patent < ApplicationRecord
end

# Play around!
patent1 = Patent.create(person_id: 'cycler2', name: 'Simulator Anti-Gravity', title: 'A device to make riding uphill simpler')
patent2 = Patent.create(person_id: 'cycler2', name: 'Jello Exo-Skello', title: 'An after dinner treat to increase the feeble')
patent3 = Patent.create(person_id: 'sleeper3', name: 'Compressor Nap', title: 'A device which allows a 30 minute nap in just 5 minutes')
