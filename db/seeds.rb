User.delete_all

path = Rails.root.join("design/starter-code/assets/user-images/")
images = Dir.children(path)

1.upto(5).each do |index|
  user = FactoryBot.create(:user, username: "user#{index}")
  image = images.pop
  user.avatar.attach(io: File.open(path + image), filename: image, content_type: "image/jpg")
end
