# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

collaborator = Collaborator.create(name: 'Marcus Paes', email: 'paesms@hotmail.com', fone1: '98331076', password: 'rat26600', password_confirmation: 'rat26600')
collaborator.toggle!(:admin)
