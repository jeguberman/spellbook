def populate
  spells = JSON.parse File.read "spells.json"

  spells.map{|e|
    e['class'].split(", ")
  }.flatten.uniq.sort.each {|klass|
    Klass.create!(name:klass)
  }

  spells.each do |spell|
    spl = Spell.create!(
      name: spell["name"],
      school: spell["school"],
      level: spell["level"],
      book: spell["page"],
      range: spell["range"],
      components: spell["components"],
      ritual: get_boolean(spell['ritual']),
      concentration: get_boolean(spell['concentration']),
      casting_time: spell["casting_time"],
      # description: spell["desc"],
      # materials: spell["material"],
      # higher_levels: spell["higher_levels"],
    )
    casters = Klass.where({name: spell['class'].split(", ")})
    spl.klasses = casters

  end



end

def get_boolean(str)
  return 0 if str == "no"
  return 1
end
