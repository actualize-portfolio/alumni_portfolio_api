# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe 'relationships' do
    subject { build(:phone) }

    it { is_expected.to belong_to(:location) }
  end
end
