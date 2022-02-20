Comment.delete_all
Vote.delete_all
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

1.upto(4).each do |item|
  user = FactoryBot.create(:customer, username: "customer#{item}")
  image = images.pop
  user.avatar.attach(io: File.open(path + image), filename: image, content_type: "image/jpg")
  4.times do
    FactoryBot.create(:feedback, user: user)
  end
end

1.upto(200).each do |item|
  user = User.all.sample
  feedback = Feedback.all.sample
  vote = Vote.new(feedback: feedback, user: user)
  if vote.valid?
    vote.save!
  end
end

1.upto(30).each do |item|
  user = User.all.sample
  feedback = Feedback.all.sample
  FactoryBot.create(:comment, commentable: feedback, user: user)
end

1.upto(2).each do |index|
  FactoryBot.create(:customer, username: "not_voted#{index}")
end
