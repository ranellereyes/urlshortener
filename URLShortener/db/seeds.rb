# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
ranelle = User.create!(email: 'pascsdsdffdecost@piecost.com')
sunny = User.create!(email: 'asdssdfdfcty@piecost.com')

ShortenedUrl.destroy_all
u = ShortenedUrl.this_is_kinda_create!(ranelle, 'fakessdfdsfsdfdite.com/mass/density')

Visit.destroy_all
Visit.record_visit!(ranelle, u)
Visit.record_visit!(sunny, u)
