# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubApi do
  subject(:github_api) { described_class.new(username) }

  let(:username) { 'gatorjuice' }

  describe '#user', vcr: true do
    let(:expected) do
      {
        'avatar_url' => 'https://avatars.githubusercontent.com/u/11019755?v=4',
        'bio' => nil,
        'blog' => '',
        'company' => nil,
        'created_at' => '2015-02-15T19:17:14Z',
        'email' => nil,
        'events_url' => 'https://api.github.com/users/gatorjuice/events{/privacy}',
        'followers' => 11,
        'followers_url' => 'https://api.github.com/users/gatorjuice/followers',
        'following' => 7,
        'following_url' => 'https://api.github.com/users/gatorjuice/following{/other_user}',
        'gists_url' => 'https://api.github.com/users/gatorjuice/gists{/gist_id}',
        'gravatar_id' => '',
        'hireable' => nil,
        'html_url' => 'https://github.com/gatorjuice',
        'id' => 11_019_755,
        'location' => nil,
        'login' => 'gatorjuice',
        'name' => 'Jamie',
        'node_id' => 'MDQ6VXNlcjExMDE5NzU1',
        'organizations_url' => 'https://api.github.com/users/gatorjuice/orgs',
        'public_gists' => 2,
        'public_repos' => 58,
        'received_events_url' => 'https://api.github.com/users/gatorjuice/received_events',
        'repos_url' => 'https://api.github.com/users/gatorjuice/repos',
        'site_admin' => false,
        'starred_url' => 'https://api.github.com/users/gatorjuice/starred{/owner}{/repo}',
        'subscriptions_url' => 'https://api.github.com/users/gatorjuice/subscriptions',
        'twitter_username' => nil,
        'type' => 'User',
        'updated_at' => '2021-11-16T01:02:18Z',
        'url' => 'https://api.github.com/users/gatorjuice'
      }
    end

    it 'gets body of user response' do
      expect(github_api.user).to eq(expected)
    end
  end

  describe '#repositories', vcr: true do
    context 'when per_page is not set' do
      it 'returns 30 repositories' do
        expect(github_api.repositories.count).to eq(30)
      end
    end

    context 'when per_page is set to x number of repos' do
      it 'returns x repos' do
        expect(github_api.repositories(per_page: 35).count).to eq(35)
      end
    end
  end
end
