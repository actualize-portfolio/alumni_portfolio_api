# frozen_string_literal: true

class AddIndexToSunnyEpisodeUserRankings < ActiveRecord::Migration[7.0]
  def change
    add_index :sunny_episode_user_rankings, %i[better_episode_id user_id], name: 'index_seur_on_beid_and_uid'
  end
end
