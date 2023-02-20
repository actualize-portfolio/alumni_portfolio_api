# frozen_string_literal: true

class AddIndexesToSunnyEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_index :sunny_episode_user_rankings, %i[better_episode_id user_id], unique: true
    add_index :sunny_episode_user_rankings, %i[worse_episode_id user_id], unique: true
    add_index :sunny_episodes, :id
  end
end
