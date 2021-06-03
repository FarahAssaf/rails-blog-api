FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}#{Faker::Internet.safe_email}" }
    password { 'very_strong_password*wink*' }
  end
end
