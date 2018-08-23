FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test#{n}" }
    sequence(:email) { |n| "test#{n}@test.co.jp" }
    sequence(:password) { |n| "password#{n}" }
  end
end
