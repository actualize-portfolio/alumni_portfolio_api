# frozen_string_literal: true

class AddDataToGithubRepos < ActiveRecord::Migration[7.0]
  def change
    add_column :github_repos, :data, :jsonb, default: {}
  end
end
