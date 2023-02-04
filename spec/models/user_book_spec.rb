# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBook do
  describe 'relationships' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end
end
