# frozen_string_literal: true

module Api
  module V1
    # Sunny Episodes Controller
    class SunnyEpisodesController < ApplicationController
      before_action :authorize_user

      def index
        result = SunnyEpisodes::Index.call(user: logged_in_user)

        render_success(
          top_hundred: result.top_hundred,
          top_hundred_by_user: result.top_hundred_by_user
        )
      end
    end
  end
end
