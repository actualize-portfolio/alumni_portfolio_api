# frozen_string_literal: true

module Api
  module V1
    # Sunny Episodes Controller
    class SunnyEpisodesController < ApplicationController
      before_action :authorize_user

      def index
        render_success(
          top_ten: SunnyEpisode.top_ten,
          top_ten_by_user: SunnyEpisode.top_ten_by_user(logged_in_user)
        )
      end
    end
  end
end
