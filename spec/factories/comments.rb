FactoryBot.define do
  factory :comment do
    user { nil }
    commentable { nil }
    parent_id { nil }
    content { Faker::Lorem.paragraph(sentence_count: rand(3..8)) }
  end
end
