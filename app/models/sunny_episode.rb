# frozen_string_literal: true

# An episode of "It's always Sunny in Philadelphia"
class SunnyEpisode < ApplicationRecord
  has_many :wins,
           class_name: 'SunnyEpisodeUserRanking',
           foreign_key: :better_episode_id,
           inverse_of: :better_episode,
           dependent: :destroy

  has_many :losses,
           class_name: 'SunnyEpisodeUserRanking',
           foreign_key: :worse_episode_id,
           inverse_of: :worse_episode,
           dependent: :destroy

  validates :number, uniqueness: true
  validates :episode, uniqueness: { scope: :season }

  scope :random_two, lambda { |user|
    joins("LEFT OUTER JOIN sunny_episode_user_rankings ON sunny_episode_user_rankings.better_episode_id = sunny_episodes.id AND sunny_episode_user_rankings.user_id = #{user.id}")
      .where(sunny_episode_user_rankings: { id: nil })
      .order('RANDOM()')
      .limit(2)
  }

  scope :top_hundred, lambda {
    joins(:wins)
      .group(:id)
      .order('COUNT(better_episode_id) DESC')
      .limit(100)
  }

  scope :top_hundred_by_user, lambda { |user|
    top_hundred.where(sunny_episode_user_rankings: { user_id: user.id })
  }
end
