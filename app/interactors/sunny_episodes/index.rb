# frozen_string_literal: true

module SunnyEpisodes
  # Returns Top Ten Sunny Episodes
  class Index
    include Interactor

    def call
      context.top_ten = SunnyEpisode.top_ten
      context.top_ten_by_user = SunnyEpisode.top_ten_by_user(context.user)
    end
  end
end
