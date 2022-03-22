# frozen_string_literal: true

module Api
  module V1
    class SunnyEpisodesController < ApplicationController
      def index
        render_success(SunnyEpisode.top_ten)
      end
    end
  end
end
