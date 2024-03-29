# frozen_string_literal: true

# User class
class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :sunny_episode_user_rankings, dependent: :destroy
  has_many :sunny_episodes, through: :sunny_episode_user_rankings, source: :better_episode
end
