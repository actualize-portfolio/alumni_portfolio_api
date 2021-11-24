# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubRepo, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:organization) }
    it { is_expected.to validate_presence_of(:project) }
    it { is_expected.to validate_uniqueness_of(:project).scoped_to(:organization) }
  end

  describe 'fetch_repo_data!', vcr: true do
    context 'when repo exists' do
      let(:github_repo) { create(:github_repo) }

      it 'sets repo_data' do
        github_repo.fetch_repo_data!

        expect(github_repo.repo_data).not_to be_nil
      end
    end

    context 'when repo does not exist' do
      let(:github_repo) { create(:github_repo, :skip_validate) }

      it 'logs an error' do
        allow(Rails.logger).to receive(:error)

        github_repo.fetch_repo_data!

        expect(Rails.logger).to have_received(:error).with(
          '{"message":"Not Found","documentation_url":"https://docs.github.com/rest/reference/repos#get-a-repository"}'
        )
      end

      it 'does not set repo_data' do
        github_repo.fetch_repo_data!

        expect(github_repo.repo_data).to be_nil
      end
    end
  end
end
