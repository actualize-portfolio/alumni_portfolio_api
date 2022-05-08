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

  describe '#repository', vcr: true do
    let(:username) { 'vuejs' }
    let(:expected) do
      {
        'allow_forking' => true,
        'archive_url' => 'https://api.github.com/repos/vuejs/vue/{archive_format}{/ref}',
        'archived' => false,
        'assignees_url' => 'https://api.github.com/repos/vuejs/vue/assignees{/user}',
        'blobs_url' => 'https://api.github.com/repos/vuejs/vue/git/blobs{/sha}',
        'branches_url' => 'https://api.github.com/repos/vuejs/vue/branches{/branch}',
        'clone_url' => 'https://github.com/vuejs/vue.git',
        'collaborators_url' => 'https://api.github.com/repos/vuejs/vue/collaborators{/collaborator}',
        'comments_url' => 'https://api.github.com/repos/vuejs/vue/comments{/number}',
        'commits_url' => 'https://api.github.com/repos/vuejs/vue/commits{/sha}',
        'compare_url' => 'https://api.github.com/repos/vuejs/vue/compare/{base}...{head}',
        'contents_url' => 'https://api.github.com/repos/vuejs/vue/contents/{+path}',
        'contributors_url' => 'https://api.github.com/repos/vuejs/vue/contributors',
        'created_at' => '2013-07-29T03:24:51Z',
        'default_branch' => 'dev',
        'deployments_url' => 'https://api.github.com/repos/vuejs/vue/deployments',
        # rubocop:disable Layout/LineLength
        'description' => '🖖 Vue.js is a progressive, incrementally-adoptable JavaScript framework for building UI on the web.',
        # rubocop:enable Layout/LineLength
        'disabled' => false,
        'downloads_url' => 'https://api.github.com/repos/vuejs/vue/downloads',
        'events_url' => 'https://api.github.com/repos/vuejs/vue/events',
        'fork' => false,
        'forks' => 31_184,
        'forks_count' => 31_184,
        'forks_url' => 'https://api.github.com/repos/vuejs/vue/forks',
        'full_name' => 'vuejs/vue',
        'git_commits_url' => 'https://api.github.com/repos/vuejs/vue/git/commits{/sha}',
        'git_refs_url' => 'https://api.github.com/repos/vuejs/vue/git/refs{/sha}',
        'git_tags_url' => 'https://api.github.com/repos/vuejs/vue/git/tags{/sha}',
        'git_url' => 'git://github.com/vuejs/vue.git',
        'has_downloads' => true,
        'has_issues' => true,
        'has_pages' => false,
        'has_projects' => true,
        'has_wiki' => true,
        'homepage' => 'http://vuejs.org',
        'hooks_url' => 'https://api.github.com/repos/vuejs/vue/hooks',
        'html_url' => 'https://github.com/vuejs/vue',
        'id' => 11_730_342,
        'is_template' => false,
        'issue_comment_url' => 'https://api.github.com/repos/vuejs/vue/issues/comments{/number}',
        'issue_events_url' => 'https://api.github.com/repos/vuejs/vue/issues/events{/number}',
        'issues_url' => 'https://api.github.com/repos/vuejs/vue/issues{/number}',
        'keys_url' => 'https://api.github.com/repos/vuejs/vue/keys{/key_id}',
        'labels_url' => 'https://api.github.com/repos/vuejs/vue/labels{/name}',
        'language' => 'JavaScript',
        'languages_url' => 'https://api.github.com/repos/vuejs/vue/languages',
        'license' => {
          'key' => 'mit',
          'name' => 'MIT License',
          'node_id' => 'MDc6TGljZW5zZTEz',
          'spdx_id' => 'MIT',
          'url' => 'https://api.github.com/licenses/mit'
        },
        'merges_url' => 'https://api.github.com/repos/vuejs/vue/merges',
        'milestones_url' => 'https://api.github.com/repos/vuejs/vue/milestones{/number}',
        'mirror_url' => nil,
        'name' => 'vue',
        'network_count' => 31_184,
        'node_id' => 'MDEwOlJlcG9zaXRvcnkxMTczMDM0Mg==',
        'notifications_url' => 'https://api.github.com/repos/vuejs/vue/notifications{?since,all,participating}',
        'open_issues' => 549,
        'open_issues_count' => 549,
        'organization' => {
          'avatar_url' => 'https://avatars.githubusercontent.com/u/6128107?v=4',
          'events_url' => 'https://api.github.com/users/vuejs/events{/privacy}',
          'followers_url' => 'https://api.github.com/users/vuejs/followers',
          'following_url' => 'https://api.github.com/users/vuejs/following{/other_user}',
          'gists_url' => 'https://api.github.com/users/vuejs/gists{/gist_id}',
          'gravatar_id' => '',
          'html_url' => 'https://github.com/vuejs',
          'id' => 6_128_107,
          'login' => 'vuejs',
          'node_id' => 'MDEyOk9yZ2FuaXphdGlvbjYxMjgxMDc=',
          'organizations_url' => 'https://api.github.com/users/vuejs/orgs',
          'received_events_url' => 'https://api.github.com/users/vuejs/received_events',
          'repos_url' => 'https://api.github.com/users/vuejs/repos',
          'site_admin' => false,
          'starred_url' => 'https://api.github.com/users/vuejs/starred{/owner}{/repo}',
          'subscriptions_url' => 'https://api.github.com/users/vuejs/subscriptions',
          'type' => 'Organization',
          'url' => 'https://api.github.com/users/vuejs'
        },
        'owner' => {
          'avatar_url' => 'https://avatars.githubusercontent.com/u/6128107?v=4', 'events_url' => 'https://api.github.com/users/vuejs/events{/privacy}',
          'followers_url' => 'https://api.github.com/users/vuejs/followers',
          'following_url' => 'https://api.github.com/users/vuejs/following{/other_user}',
          'gists_url' => 'https://api.github.com/users/vuejs/gists{/gist_id}',
          'gravatar_id' => '',
          'html_url' => 'https://github.com/vuejs',
          'id' => 6_128_107,
          'login' => 'vuejs',
          'node_id' => 'MDEyOk9yZ2FuaXphdGlvbjYxMjgxMDc=',
          'organizations_url' => 'https://api.github.com/users/vuejs/orgs',
          'received_events_url' => 'https://api.github.com/users/vuejs/received_events',
          'repos_url' => 'https://api.github.com/users/vuejs/repos',
          'site_admin' => false,
          'starred_url' => 'https://api.github.com/users/vuejs/starred{/owner}{/repo}',
          'subscriptions_url' => 'https://api.github.com/users/vuejs/subscriptions',
          'type' => 'Organization',
          'url' => 'https://api.github.com/users/vuejs'
        },
        'permissions' => { 'admin' => false, 'maintain' => false, 'pull' => true, 'push' => false, 'triage' => false },
        'private' => false,
        'pulls_url' => 'https://api.github.com/repos/vuejs/vue/pulls{/number}',
        'pushed_at' => '2022-01-13T14:27:26Z',
        'releases_url' => 'https://api.github.com/repos/vuejs/vue/releases{/id}',
        'size' => 27_666,
        'ssh_url' => 'git@github.com:vuejs/vue.git',
        'stargazers_count' => 192_228,
        'stargazers_url' => 'https://api.github.com/repos/vuejs/vue/stargazers',
        'statuses_url' => 'https://api.github.com/repos/vuejs/vue/statuses/{sha}',
        'subscribers_count' => 6179,
        'subscribers_url' => 'https://api.github.com/repos/vuejs/vue/subscribers',
        'subscription_url' => 'https://api.github.com/repos/vuejs/vue/subscription',
        'svn_url' => 'https://github.com/vuejs/vue',
        'tags_url' => 'https://api.github.com/repos/vuejs/vue/tags',
        'teams_url' => 'https://api.github.com/repos/vuejs/vue/teams',
        'temp_clone_token' => '',
        'topics' => %w[framework frontend javascript vue],
        'trees_url' => 'https://api.github.com/repos/vuejs/vue/git/trees{/sha}',
        'updated_at' => '2022-01-13T18:38:56Z',
        'url' => 'https://api.github.com/repos/vuejs/vue',
        'visibility' => 'public',
        'watchers' => 192_228,
        'watchers_count' => 192_228
      }
    end

    it 'returns response body on given project' do
      expect(github_api.repository('vue')).to eq(expected)
    end
  end
end
