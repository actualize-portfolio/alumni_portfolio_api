# frozen_string_literal: true

class SunnyEpisodeUserRanking < ApplicationRecord
  belongs_to :user
  belongs_to :better_episode, class_name: 'SunnyEpisode'
  belongs_to :worse_episode, class_name: 'SunnyEpisode'

  scope :top_10_episodes, lambda {
    group(:better_episode_id)
      .order('better_episode_id DESC')
      .limit(10)
      .count(:better_episode_id)
      .map { |episode_id, _| SunnyEpisode.find(episode_id) }
  }
end
