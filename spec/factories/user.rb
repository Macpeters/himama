FactoryBot.define do
  factory :user do
    name { "Joe Smith" }
    sequence(:email) { |n| "test_#{n}@gmail.com" }
    password { "blah123456" }
  end
end