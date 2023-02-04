# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location do
  describe 'relationships' do
    subject { build(:location) }

    it { is_expected.to belong_to(:service_web_resource) }
    it { is_expected.to belong_to(:address) }
    it { is_expected.to have_many(:phones).dependent(:destroy) }
  end
end
