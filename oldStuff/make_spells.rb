require 'json'
require 'sqlite3'
def get_spells
  all_spells = JSON.parse File.read("spells.json")

  spells = all_spells.select do |spell|
    spell["class"].include?("Wizard") &&
    !spell["page"].include?("ee") &&
    spell["level"][0].to_i <= 5
  end

  return spells
end

spells = get_spells.sort_by { |e|  e['level'] }

index = File.open("index.html", "w")

spells.each do |e|
  index.puts "<div>"
  index.puts "<h3>#{e['name']}</h3>"
  index.puts e['level']
  index.puts "Range: #{e['range']}, Duration: #{e['duration']}, Casting Time: #{e['casting_time']} School: #{e['school']}"
  index.puts e['desc']
  index.puts   "</div>"
  index.puts
end


# db = SQLite3::Database.new("spells.db")
# db.execute <<-SQL
#    CREATE TABLE IF NOT EXISTS spells (
#      id INTEGER PRIMARY KEY AUTOINCREMENT,
#      name varchar(50) NOT NULL,
#      description text NOT NULL,
#      page varchar(20) NOT NULL,
#      varchar(50) NOT NULL,
#      varchar(50) NOT NULL,
#      varchar(50) NOT NULL,
#      varchar(50) NOT NULL,
#      varchar(50) NOT NULL,
#      varchar(50) NOT NULL,
#      varchar(50) NOT NULL,
#      varchar(50) NOT NULL,
#      varchar(50) NOT NULL,
#      varchar(50) NOT NULL,
#
#    );
# SQL

# options = File.open("options","w");

# all_spells = JSON.parse File.read("spells.json")
# all_spells[0].keys.each do |field|
#   # puts field + spells.sort_by {|e| e[field].length}[-1][field].length.to_s
# end
