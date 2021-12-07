# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :restrict_with_exception
  # has_one :categories, as: :categorable, dependent: :destroy
  has_many :comments, dependent: :restrict_with_exception
end
