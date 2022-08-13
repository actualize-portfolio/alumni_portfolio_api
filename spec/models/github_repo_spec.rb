# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubRepo, type: :model do
  describe 'validations', vcr: true do
    it { is_expected.to validate_presence_of(:organization) }
    it { is_expected.to validate_presence_of(:project) }
    it { is_expected.to validate_uniqueness_of(:project).scoped_to(:organization) }
  end

  describe 'fetch_repo_data!', vcr: true do
    let(:github_repo) { create(:github_repo) }

    it 'sets repo_data' do
      github_repo.fetch_repo_data!

      expect(github_repo.data).not_to be_nil
    end
  end
end
