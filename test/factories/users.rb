FactoryBot.define do
  factory :user do
    first_name { 'John' }
    sequence(:last_name) { |n| "Doe#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'passw0rd' }
    password_confirmation { 'passw0rd' }
  end
end
