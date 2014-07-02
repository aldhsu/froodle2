# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Prompt.destroy_all
Doodle.destroy_all

p1 = Prompt.create(question: "Justine Beiber", difficulty: 5)
p2 = Prompt.create(question: "Michael Jackson", difficulty: 3)
p3 = Prompt.create(question: "Forrest Gump", difficulty: 6)
p4 = Prompt.create(question: "Rolf Harris", difficulty: 4)
p5 = Prompt.create(question: "Hodor", difficulty: 7)
