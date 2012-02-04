# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create basic Label based on DYMO 2.125" x 4"

Label.create(name: 'DYMO Standard', width: 4, height: 2.125)

Preference.create

User.create(
  login: 'user', email: 'user@example.com', password: 'password', password_confirmation: 'password'
)
