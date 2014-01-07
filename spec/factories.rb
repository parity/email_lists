FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
  end
  factory :list do
  	name	"devs"
  	address "devs@example.com"
  	description "list for devs"
  end
  factory :subscription do
  	association :user, factory: :user
  	association :list, factory: :list
  end
end