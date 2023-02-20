# frozen_string_literal: true

class AddIndexesToSunnyEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_index :sunny_episode_user_rankings, %i[better_episode_id user_id], name: 'idx_better_user'
    add_index :sunny_episode_user_rankings, %i[worse_episode_id user_id], name: 'idx_worse_user'
    add_index :sunny_episodes, :id
  end
end
