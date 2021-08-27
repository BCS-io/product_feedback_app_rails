User.delete_all

(1..5).each do |item|
  FactoryBot.create(:user, username: "user#{item}")
end
