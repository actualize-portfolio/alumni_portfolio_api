# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubRepos::Index, type: :interactor do
  subject(:context) { described_class.call(params: params) }

  let!(:language_repo) do
    create(:github_repo, :skip_validate, organization: 'a', category: :language)
  end

  let!(:javascript_framework_repo) do
    create(:github_repo, :skip_validate, organization: 'b', category: :javascript_framework)
  end

  let!(:fullstack_framework_repo) do
    create(:github_repo, :skip_validate, organization: 'c', category: :fullstack_framework)
  end

  let(:repo_double) { double(value!: double(repo_data: {}))}

  before do
    allow(Concurrent::Promise).to receive(:execute).and_yield(double(fetch_repo_data!: {}))
  end

  describe '.call' do
    context 'when category is not sent' do
      let(:params) { { category: nil } }

      it 'returns a successful context' do
        expect(context).to be_a_success
      end

      it 'returns all the Repos' do
        expect(context.github_repos).to contain_exactly(
          language_repo,
          javascript_framework_repo,
          fullstack_framework_repo
        )
      end
    end

    context 'when category is sent' do
      let(:params) { { category: 'language' } }

      it 'returns a successful context' do
        expect(context).to be_a_success
      end

      it 'returns only the Repos that match the category' do
        expect(context.github_repos).to contain_exactly(language_repo)
      end
    end
  end
end
