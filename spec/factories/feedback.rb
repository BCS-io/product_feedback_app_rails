FactoryBot.define do
  factory :feedback do
    title { Faker::Lorem.sentence(word_count: rand(2..10)).chomp(".") }
    category { Feedback.categories.keys.sample }
    upvotes { rand(1..110) }
    status { Feedback.statuses.keys.sample }
    description { "MyText" }
    user { nil }
  end
end
