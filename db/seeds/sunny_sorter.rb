# frozen_string_literal: true

require 'csv'

User.destroy_all

users = [
  { username: 'demo_user@test.com', password: 'p@ssw@rd' },
  { username: 'gatorjuice@gmail.com', password: 'p@ssw@rd' }
]

User.create!(users)

# At startup, delete and reimport all the Sunny Episodes
SunnyEpisode.destroy_all
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

User.all.each do |user|
  100.times do
    FactoryBot.create(:sunny_episode_user_ranking, user:)
  end
end
