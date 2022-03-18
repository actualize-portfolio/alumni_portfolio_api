# frozen_string_literal: true

# User class
class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  validates :username, :password_digest, :age, presence: true
  validates :username, uniqueness: true
  validates :age, numericality: { only_integer: true }

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :sunny_episode_user_rankings

  def favorite_sunny_episode

  end
end
