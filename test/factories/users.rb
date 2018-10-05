FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'email@example.com' }
    password { 'passw0rd' }
    password_confirmation { 'passw0rd' }
  end
end
