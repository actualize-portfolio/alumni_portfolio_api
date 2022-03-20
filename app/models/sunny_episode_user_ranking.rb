# frozen_string_literal: true

class SunnyEpisodeUserRanking < ApplicationRecord
  belongs_to :user
  belongs_to :better_episode, class_name: 'SunnyEpisode'
  belongs_to :worse_episode, class_name: 'SunnyEpisode'
end
