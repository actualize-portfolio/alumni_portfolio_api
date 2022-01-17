# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'health_check', type: :request do
  it 'returns a success response' do
    get health_check_path

    expect(response).to have_http_status(:success)
  end
end
