User.delete_all

(1..5).each do |item|
  FactoryBot.create(:user, email: "user#{item}@example.com")
end
