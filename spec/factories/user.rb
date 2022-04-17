FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test-user#{n}"}
    sequence(:email) { |n| "test#{n}@gmail.com"}
    password { "password" }
    password_confirmation { "password" }

    trait :main_user do
      sequence(:name) { |n| "user#{n}"}
      sequence(:email) { |n| "user#{n}@gmail.com"}
    end

    trait :another_user do
      sequence(:name) { |n| "another_user#{n}"}
      sequence(:email) { |n| "another#{n}@gmail.com"}
    end
  end
end