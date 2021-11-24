# frozen_string_literal: true

class CreateGithubRepos < ActiveRecord::Migration[6.1]
  def change
    create_table :github_repos do |t|
      t.string :organization
      t.string :project
      t.integer :category

      t.timestamps
    end

    add_index :github_repos, %i[organization project], unique: true
  end
end
