# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create roles
["admin", "user"].each do |role_name|
  Role.find_or_create_by(name: role_name)
end

# Create admin user
User.new(role_id: 1, email: 'admin@admin.com', password: 'password', name: 'admin').save
