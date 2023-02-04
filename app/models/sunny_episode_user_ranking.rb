# frozen_string_literal: true

# A Join model that links user ratings to a Sunny episode
class SunnyEpisodeUserRanking < ApplicationRecord
  belongs_to :user
  belongs_to :better_episode, class_name: 'SunnyEpisode'
  belongs_to :worse_episode, class_name: 'SunnyEpisode'
end
