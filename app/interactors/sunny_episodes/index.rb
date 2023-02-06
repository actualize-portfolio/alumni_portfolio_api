# frozen_string_literal: true

module SunnyEpisodes
  # Returns Top 100 Sunny Episodes
  class Index
    include Interactor

    def call
      context.top_hundred = SunnyEpisode.top_hundred
      context.top_hundred_by_user = SunnyEpisode.top_hundred_by_user(context.user)
      context.ranked_seasons = SunnyEpisodeUserRanking.ranked_seasons
      context.ranked_seasons_by_user = SunnyEpisodeUserRanking.ranked_seasons_by_user(context.user)
    end
  end
end
