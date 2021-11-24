# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::GithubRepos', type: :request do
  include RequestSpecHelper

  let!(:user) { create(:user, password: password) }

  let(:password) { 'p@ssw@rd' }
  let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
  let(:token) { login_user_for_token(user.username, password) }

  describe 'GET_index', vcr: true do
    let(:expected) do
      [
        {
          'id' => a_kind_of(Integer),
          'name' => 'vue',
          'full_name' => 'vuejs/vue',
          'category' => 'javascript_framework',
          'forks_count' => a_kind_of(Integer),
          'stargazers_count' => a_kind_of(Integer),
          'watchers_count' => a_kind_of(Integer),
          'popularity_rating' => a_kind_of(Integer)
        },
        {
          'id' => a_kind_of(Integer),
          'name' => 'react',
          'full_name' => 'facebook/react',
          'category' => 'javascript_framework',
          'forks_count' => a_kind_of(Integer),
          'stargazers_count' => a_kind_of(Integer),
          'watchers_count' => a_kind_of(Integer),
          'popularity_rating' => a_kind_of(Integer)
        },
        {
          'id' => a_kind_of(Integer),
          'name' => 'angular.js',
          'full_name' => 'angular/angular.js',
          'category' => 'javascript_framework',
          'forks_count' => a_kind_of(Integer),
          'popularity_rating' => a_kind_of(Integer),
          'stargazers_count' => a_kind_of(Integer),
          'watchers_count' => a_kind_of(Integer)
        }
      ]
    end

    before do
      create(:github_repo, organization: 'vuejs', project: 'vue')
      create(:github_repo, organization: 'facebook', project: 'react')
      create(:github_repo, organization: 'angular', project: 'angular.js')
      create(:github_repo, :skip_validate, organization: 'non-existent-org', project: 'error')
    end

    it 'returns http success' do
      get api_v1_github_repos_path, headers: headers

      expect(response).to have_http_status(:success)
    end

    it 'returns the correct data' do
      get api_v1_github_repos_path, headers: headers

      expect(data).to match_array(expected)
    end
  end
end
