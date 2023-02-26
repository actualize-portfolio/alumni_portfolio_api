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
        # Delete the old records and create the new one in a single transaction
        SunnyEpisodeUserRanking.transaction do
          old_rankings.delete_all

          logged_in_user.sunny_episode_user_rankings.create(
            worse_episode_id: params.require(:worse_id),
            better_episode_id: params.require(:better_id)
          )
        end

        render_success(SunnyEpisode.random_two)
      end

      private

      def old_rankings
        logged_in_user.sunny_episode_user_rankings.where(
          '(worse_episode_id = :worse_id AND better_episode_id = :better_id) OR ' \
          '(worse_episode_id = :better_id AND better_episode_id = :worse_id)',
          worse_id: params.require(:worse_id),
          better_id: params.require(:better_id)
        )
      end
    end
  end
end
