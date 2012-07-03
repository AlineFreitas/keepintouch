namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin=Collaborator.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 fone1: "00000000",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)

    99.times do |n|
      name  = Faker::Name.name
      fone1 = "11111111"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      Collaborator.create!(name: name,
                   email: email,
                   fone1: fone1,
                   password: password,
                   password_confirmation: password)
    end
    
    collaborators = Collaborator.all(limit: 6)
    50.times do
      name = Faker::Lorem.sentence(5)
      collaborators.each { |collaborator| collaborator.partners.create!(name: name) }
    end
  end
end
