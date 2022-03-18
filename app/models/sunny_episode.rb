# frozen_string_literal: true

class SunnyEpisode < ApplicationRecord
  has_many :sunny_episode_user_rankings

  validates :number, uniqueness: true
  validates :episode, uniqueness: { scope: :season }
end
