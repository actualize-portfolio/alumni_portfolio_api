# frozen_string_literal: true

module Api
  module V1
    class SunnyEpisodesController < ApplicationController
      def index
        render_success(SunnyEpisode.order('RANDOM()').limit(2))
      end
    end
  end
end
