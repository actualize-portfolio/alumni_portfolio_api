# frozen_string_literal: true

require 'csv'

unless Rails.env.test?
  # At startup, delete and reimport all the Sunny Episodes
  file = Rails.public_path.join('csv/sunny_episode_list.csv')

  episodes = CSV.parse(File.read(file), headers: true)

  # Import only new episodes
  episodes.each do |episode|
    next if SunnyEpisode.find_by(number: episode['number'])

    Rails.logger.info("Adding episode #{episode['number']}")
    ep = SunnyEpisode.new(episode)
    ep.airdate = Date.parse(episode['airdate'])
    ep.save!
  end
end
