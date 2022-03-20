# frozen_string_literal: true

module Api
  module V1
    class SunnyEpisodesController < ApplicationController
      def index
        render_success(SunnyEpisode.random_two)
      end
    end
  end
end
