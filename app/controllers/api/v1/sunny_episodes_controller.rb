class Api::V1::SunnyEpisodesController < ApplicationController
  def index
    render_success(SunnyEpisode.order('RANDOM()').limit(2))
  end
end
