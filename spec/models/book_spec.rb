# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:user_books).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:user_books) }
  end
end
