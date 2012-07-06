# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

collaborator = Collaborator.create(name: 'Marcus Paes', gender: 'Homem', email: 'paesms@hotmail.com', birth_date: '29/07/1956', street: 'Avenida Alberto Torres', number: 266, hood: 'Centro', cep: '00000000', fone1: '98331076', password: 'rat26600', password_confirmation: 'rat26600')
collaborator.toggle!(:admin)
