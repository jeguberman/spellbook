require 'active_record'
# require 'sqlite3'
require 'pry'

require_relative 'dbseed'
# require_relative 'readyClasses'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :spells, force: true do |t|
    t.string "name", null: false
    t.string "school", null: false, limit: 15
    t.integer "level", null: false
    t.string "book", limit: 10
    # t.integer "page"
    t.string "range", null: false
    t.string "components", limit: 3
    t.boolean "ritual"
    t.boolean "concentration"
    t.string "casting_time"
    t.text "description"
    t.text "materials"
    t.text "higher_levels"
    t.timestamps
  end

  create_table :klasses, force: true do |t|
    t.string "name", null: false
    # t.string "spell_stat", limit: 3, null: false
    t.timestamps
  end

  create_join_table :spells, :klasses, force: true do |t|
    t.index :spell_id
    t.index :klass_id
  end

  # create_table :spell_book, force: true do |t|


end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Spell < ApplicationRecord
  validates :name, presence: true

  after_initialize :clean_level

  has_and_belongs_to_many :klasses

  def clean_level
    self.level = self.level[0].to_i
  end
end

class Klass < ApplicationRecord
  validates :name, presence: true

  # has_and_belongs_to_many :spells
  has_many :spellsAssociations,
    table

  scope :spells, -> {include(:spells)}

end

populate

pry
