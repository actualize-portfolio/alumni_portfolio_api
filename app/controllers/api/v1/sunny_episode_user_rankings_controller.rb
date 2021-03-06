# frozen_string_literal: true

module Api
  module V1
    # Sunny Episodes User Rankings Controller
    class SunnyEpisodeUserRankingsController < ApplicationController
      before_action :authorize_user

      def index
        render_success(SunnyEpisode.random_two)
      end

      def create
        SunnyEpisodeUserRanking.create(
          user: logged_in_user,
          worse_episode_id: params.require(:worse_id),
          better_episode_id: params.require(:better_id)
        )

        render_success(SunnyEpisode.random_two)
      end
    end
  end
end
