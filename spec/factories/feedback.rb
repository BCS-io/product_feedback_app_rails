FactoryBot.define do
  factory :feedback do
    title { Faker::Company.catch_phrase }
    category { Feedback.categories.keys.sample }
    status { Feedback.statuses.keys.sample }
    description { Faker::Lorem.sentence(word_count: rand(6..12)).chomp(".") }
    user { nil }
  end
end
