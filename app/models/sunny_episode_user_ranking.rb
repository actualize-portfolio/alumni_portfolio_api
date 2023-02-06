# frozen_string_literal: true

# Represents a user ranking of two episodes
class SunnyEpisodeUserRanking < ApplicationRecord
  belongs_to :user
  belongs_to :better_episode, class_name: 'SunnyEpisode'
  belongs_to :worse_episode, class_name: 'SunnyEpisode'

  scope :ranked_seasons_by_user, lambda { |user|
    joins(:better_episode)
      .where(user:)
      .group('sunny_episodes.season')
      .order('count(sunny_episodes.id) DESC')
      .select('sunny_episodes.season')
      .count('sunny_episodes.id')
  }

  scope :ranked_seasons, lambda {
    joins(:better_episode)
      .group('sunny_episodes.season')
      .order('count(sunny_episodes.id) DESC')
      .select('sunny_episodes.season')
      .count('sunny_episodes.id')
  }
end
