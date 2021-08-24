class User < ApplicationRecord
  enum role: { customer: 0, staff: 1 }, _suffix: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :feedbacks, dependent: :destroy
  has_many :votes, dependent: :destroy
end
