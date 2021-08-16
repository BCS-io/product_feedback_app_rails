Feedback.delete_all
User.delete_all

path = Rails.root.join("design/starter-code/assets/user-images/")
images = Dir.children(path)

1.upto(2).each do |index|
  user = FactoryBot.create(:staff, username: "staff#{index}")
  image = images.pop
  user.avatar.attach(io: File.open(path + image), filename: image, content_type: "image/jpg")
  4.times do
    FactoryBot.create(:feedback, user: user)
  end
end

1.upto(2).each do |item|
  user = FactoryBot.create(:customer, username: "customer#{item}")
  image = images.pop
  user.avatar.attach(io: File.open(path + image), filename: image, content_type: "image/jpg")
  4.times do
    FactoryBot.create(:feedback, user: user)
  end
end
