# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Create, type: :interactor do
  subject(:context) { described_class.call(params) }

  let(:params) { { user_params: attributes_for(:user) } }

  describe '.call' do
    context 'when the user saves' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides the user' do
        expect(context.user).to be_a(User)
      end
    end

    context 'when the user fails to save' do
      let(:params) { { user_params: attributes_for(:user).delete(:age) } }

      it 'fails the context' do
        context

        expect(context.success?).to be(false)
      end
    end
  end
end
