# frozen_string_literal: true

class AddIndexToSunnyEpisode < ActiveRecord::Migration[6.1]
  def change
    add_index :sunny_episodes, :number, unique: true
    add_index :sunny_episodes, %i[season episode], unique: true
  end
end
