# frozen_string_literal: true

class CreateSunnyEpisodes < ActiveRecord::Migration[6.1]
  def change
    create_table :sunny_episodes do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.integer :number, null: false
      t.integer :season, null: false
      t.integer :episode, null: false
      t.date :airdate, null: false
      t.string :tvmaze_link, null: false

      t.timestamps
    end
  end
end
