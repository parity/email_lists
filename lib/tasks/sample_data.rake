namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@example.com")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.com"
      User.create!(name: name,
                   email: email)
    end
    List.create!(name: "developers",
                 description: "list for developers", 
                 address: "examplelist@example.com")
    10.times do |x|
      name  = Faker::Name.name
      address = Faker::Internet.email
      description = Faker::Lorem.words(rand(2..5)).join(" ")
      List.create!(name: name,
                   address: address,
                   description: description)
    end
  end


end