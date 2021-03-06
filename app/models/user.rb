class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, translator: 1, admin: 2 }

  has_many :orders, dependent: :delete_all
  has_many :categories, as: :categorable
  has_many :replies, dependent: :delete_all
  has_many :comments, dependent: :delete_all
end
